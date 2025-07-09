#!/usr/bin/env fish
# DNS Record Types:
# A        - 32-bit IPv4
# AAAA     - 128-bit IPv6
# CNAME    - Canonical Name
# MX       - Mail Exchange
# NS       - Name Server
# PTR      - Pointer
# SOA      - Start of Authority
# SRV      - Service Locator
# TXT      - Text
# DNSKEY   - DNSSEC Key
# DS       - DNSSEC Delegation Signer
# NSEC     - DNSSEC Next Secure
# NSEC3    - DNSSEC Next Secure v3
# NSEC3PARAM - DNSSEC Next Secure v3 Parameters
# RRSIG    - DNSSEC Signature
# AFSDB    - AFS Database
# CAA      - Certificate Authority Authorization
# CERT     - Certificate
# DHCID    - DHCP Identifier
# DNAME    - Delegation Name
# HINFO    - Host Information
# LOC      - Location
# NAPTR    - Naming Authority Pointer
# TLSA     - TLSA (DANE)

# Default server and pause interval
set -l PAUSE 1
set -l SERVER "1.1.1.1"

# DNS record types
set -l TYPES A AAAA CNAME MX NS PTR SOA SRV TXT DNSKEY DS NSEC NSEC3 NSEC3PARAM RRSIG AFSDB CAA CERT DHCID DNAME HINFO LOC NAPTR TLSA

# Function to perform DNS query
function query_dns
    for type in $TYPES
        echo -n "\n$type: "
        dig @$SERVER +short $type $argv[1] 2>/dev/null
        sleep $PAUSE
    end
end

# Ensure a domain is provided
if test (count $argv) -eq 0
    echo "Usage: $argv[1] <domain>"
    exit 1
end

# Call the query function with the provided domain
query_dns $argv[1]


#!/usr/bin/env bash
# https://github.com/drduh/config/blob/master/scripts/dig.sh
# https://en.wikipedia.org/wiki/List_of_DNS_record_types
# pause="1"
# server="1.1.1.1"
# types="""A  # 32-bit ipv4
# AAAA        # 128-bit ipv6
# CNAME       # canonical
# MX          # mail exchange
# NS          # name server
# PTR         # pointer
# SOA         # zone authority
# SRV         # service locator
# TXT         # text
# DNSKEY      # dnssec key
# DS          # dnssec signer
# NSEC        # dnssec nonexistence
# NSEC3       # dnssec nonexistence
# NSEC3PARAM  # dnssec nonexistence
# RRSIG       # dnssec signature
# AFSDB       # distributed fs
# CAA         # acceptable cert authorities
# CERT        # certificate
# DHCID       # dhcp
# DNAME       # delegation name
# HINFO       # host information
# LOC         # location
# NAPTR       # naming auth pointer
# TLSA        # dane association
# """

# for type in ${types} ; do
#   if [[ ${type} =~ [A-Z] ]] ; then
#     printf "\n%s: " "${type}"
#     dig @${server} +short \
#       $(printf "%s" "${type}" | sed "s/\ \ \#.*//g") "${1}" 2>/dev/null
#     sleep "${pause}"
#   fi
# done
