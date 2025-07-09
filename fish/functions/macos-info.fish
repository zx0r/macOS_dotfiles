# macOS detection and specific information
set -g is_macos (string match -q 'Darwin' (uname -s))

if test $is_macos
    # Hardware details
    set -g hardware_model (sysctl -n hw.model)
    set -g device_model (system_profiler SPHardwareDataType | awk -F ': ' '/Model Name/ { print $2 }')
    set -g cpu_info (sysctl -n machdep.cpu.brand_string | string replace 'Apple ' '')
    set -g core_count (sysctl -n hw.ncpu)
    set -gx memory (sysctl -n hw.memsize)

    # System names
    set -gx MACHINE_NAME (scutil --get ComputerName)
    set -gx HOST_NAME (scutil --get HostName)
    set -gx LOCAL_HOST_NAME (scutil --get LocalHostName)

    # Version information
    set -l version_info (string split . (sw_vers -productVersion))
    set -g macos_version $SYSTEM_VERSION
    set -g macos_major $version_info[1]
    set -g macos_minor $version_info[2]
    set -g macos_patch $version_info[3]
    set -g macos_build (sw_vers -buildVersion)
end
