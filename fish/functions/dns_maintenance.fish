function dns_maintenance
    # Refresh hosts file
    sudo curl -sS https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts -o /etc/hosts

    # Update DNSCrypt blocklists
    dnscrypt-proxy -config (brew --prefix)/etc/dnscrypt-proxy.toml -update

    # Flush DNS cache
    sudo killall -HUP mDNSResponder

    # Verify configuration
    networksetup -getdnsservers Wi-Fi
    scutil --dns | grep 'nameserver\[0\]'
end
