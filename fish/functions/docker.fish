#!/usr/bin/env fish

# Setting up global variables
set -l btrfs_path /var/docker # Define the path for btrfs storage
set -l cgroups 'cpu,cpuacct,memory' # Define the cgroups to be used

# Function to check if a subvolume (image/container) exists
function docker_check
    btrfs subvolume list $btrfs_path | grep -qw $argv[1]; and echo 0 or echo 1
end

# Function to create a new image from a directory
function docker_init
    set -l uuid "img_(math (random) % 3352 + 42002)" # Generate a unique ID for the image
    if test -d $argv[1]
        if test (docker_check $uuid) -eq 0
            docker_run $argv
        end
        btrfs subvolume create "$btrfs_path/$uuid" >/dev/null
        cp -rf --reflink=auto $argv[1]/* "$btrfs_path/$uuid" >/dev/null
        if not test -f "$btrfs_path/$uuid/img.source"
            echo $argv[1] >"$btrfs_path/$uuid/img.source"
        end
        echo "Created: $uuid"
    else
        echo "No directory named '$argv[1]' exists"
    end
end

# Function to pull an image from Docker Hub
function docker_pull
    set -l token (curl -sL -o /dev/null -D- -H 'X-Docker-Token: true' "https://index.docker.io/v1/repositories/$argv[1]/images" | tr -d '\r' | awk -F ': *' '$1 == "X-Docker-Token" { print $2 }')
    set -l registry 'https://registry-1.docker.io/v1'
    set -l id (curl -sL -H "Authorization: Token $token" "$registry/repositories/$argv[1]/tags/$argv[2]" | sed 's/"//g')
    if test (string length $id) -ne 64
        echo "No image named '$argv[1]:$argv[2]' exists"
        return 1
    end
    set -l ancestry (curl -sL -H "Authorization: Token $token" "$registry/images/$id/ancestry")
    set -l tmp_uuid (uuidgen)
    mkdir /tmp/$tmp_uuid
    for id in (string split ',' $ancestry)
        curl -#L -H "Authorization: Token $token" "$registry/images/$id/layer" -o /tmp/$tmp_uuid/layer.tar
        tar xf /tmp/$tmp_uuid/layer.tar -C /tmp/$tmp_uuid
        rm /tmp/$tmp_uuid/layer.tar
    end
    echo "$argv[1]:$argv[2]" >/tmp/$tmp_uuid/img.source
    docker_init /tmp/$tmp_uuid
    rm -rf /tmp/$tmp_uuid
end

# Function to remove an image or container
function docker_rm
    if test (docker_check $argv[1]) -eq 1
        echo "No container named '$argv[1]' exists"
        return 1
    end
    btrfs subvolume delete "$btrfs_path/$argv[1]" >/dev/null
    cgdelete -g $cgroups:/$argv[1] &>/dev/null; or true
    echo "Removed: $argv[1]"
end

# Function to list all images
function docker_images
    echo -e "IMAGE_ID\t\tSOURCE"
    for img in (ls $btrfs_path/img_*)
        set img (basename $img)
        echo -e "$img\t\t" (cat "$btrfs_path/$img/img.source")
    end
end

# Function to list all running containers
function docker_ps
    echo -e "CONTAINER_ID\t\tCOMMAND"
    for ps in (ls $btrfs_path/ps_*)
        set ps (basename $ps)
        echo -e "$ps\t\t" (cat "$btrfs_path/$ps/$ps.cmd")
    end
end

# Function to create a container from an image
function docker_run
    set -l uuid "ps_(math (random) % 3352 + 42002)" # Generate unique container ID
    if test (docker_check $argv[1]) -eq 1
        echo "No image named '$argv[1]' exists"
        return 1
    end
    if test (docker_check $uuid) -eq 0
        echo "UUID conflict, retrying..."
        docker_run $argv
        return
    end
    set cmd (string join ' ' $argv[2..-1]) # Extract command
    set ip (string sub $uuid -3 -1) # Generate unique IP for container
    set mac (string sub $uuid -3 -1)
    # Network configuration
    ip link add dev veth0_$uuid type veth peer name veth1_$uuid
    ip link set dev veth0_$uuid up
    ip link set veth0_$uuid master bridge0
    ip netns add netns_$uuid
    ip link set veth1_$uuid netns netns_$uuid
    ip netns exec netns_$uuid ip link set dev lo up
    ip netns exec netns_$uuid ip link set veth1_$uuid address 02:42:ac:11:00$mac
    ip netns exec netns_$uuid ip addr add 10.0.0.$ip/24 dev veth1_$uuid
    ip netns exec netns_$uuid ip link set dev veth1_$uuid up
    ip netns exec netns_$uuid ip route add default via 10.0.0.1
    btrfs subvolume snapshot "$btrfs_path/$argv[1]" "$btrfs_path/$uuid" >/dev/null
    echo 'nameserver 8.8.8.8' >"$btrfs_path/$uuid/etc/resolv.conf"
    echo "$cmd" >"$btrfs_path/$uuid/$uuid.cmd"
    cgcreate -g $cgroups:/$uuid
    set -l docker_CPU_SHARE 512
    cgset -r cpu.shares=$docker_CPU_SHARE $uuid
    set -l docker_MEM_LIMIT 512
    cgset -r memory.limit_in_bytes=(math $docker_MEM_LIMIT \* 1000000) $uuid
    cgexec -g $cgroups:$uuid \
        ip netns exec netns_$uuid \
        unshare -fmuip --mount-proc \
        chroot "$btrfs_path/$uuid" \
        /bin/sh -c "/bin/mount -t proc proc /proc && $cmd" 2>&1 | tee "$btrfs_path/$uuid/$uuid.log"
    ip link del dev veth0_$uuid
    ip netns del netns_$uuid
end


# Function to view logs from a container
function docker_logs
    if test (docker_check $argv[1]) -eq 1
        echo "No container named '$argv[1]' exists"
        return 1
    end
    cat "$btrfs_path/$argv[1]/$argv[1].log"
end

# Function to commit a container to an image
function docker_commit
    if test (docker_check $argv[1]) -eq 1
        echo "No container named '$argv[1]' exists"
        return 1
    end
    if test (docker_check $argv[2]) -eq 1
        echo "No image named '$argv[2]' exists"
        return 1
    end
    docker_rm $argv[2]
    btrfs subvolume snapshot "$btrfs_path/$argv[1]" "$btrfs_path/$argv[2]" >/dev/null
    echo "Created: $argv[2]"
end

# Function to check if a container exists
function docker_check
    set container_id $argv[1]
    if test -d "$btrfs_path/$container_id"
        echo 0 # Container exists
    else
        echo 1 # Container doesn't exist
    end
end


# Function to execute a command in a running container
# function docker_exec
#     if test (docker_check $argv[1]) -eq 1
#         echo "No container named '$argv[1]' exists"
#         return 1
#     end

#     # Extract container process ID
#     set cid (ps -o ppid,pid | grep -E "^\ *[0-9]+ unshare.*$argv[1]" | awk '{print $2}')

#     # Check if the process ID is a valid number
#     if not string match -r "^\ *[0-9]+$" $cid
#         echo "Container '$argv[1]' exists but is not running"
#         return 1
#     end

#     # Execute the command inside the container using nsenter
#     nsenter -t $cid -m -u -i -n -p chroot "$btrfs_path/$argv[1]" $argv[2..-1]
# end

# Function to display help message
# function docker_help
#     sed -n "s/^.*#HELP\\s//p;" $argv[1] | sed "s/\\\\n/\n\t/g;s/$/\n/;s!docker!${argv[1]/!/\\!}!g"
# end


# # Main entry point
# if test -z "$argv[1]"
#     docker_help $argv[0] # Display help if no arguments are passed
# else
#     switch $argv[1]
#         case pull init rm images ps run exec logs commit
#             docker_"$argv[1]" $argv[2..-1] # Call the corresponding docker function
#         case '*'
#             docker_help $argv[0] # Display help for unknown commands
#     end
# end
