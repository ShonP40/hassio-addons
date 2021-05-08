#!/bin/bash

# SIGTERM-handler this funciton will be executed when the container receives the SIGTERM signal (when stopping)
reset_interfaces(){
    ifdown $INTERFACE
    sleep 1
    ip link set $INTERFACE down
    ip addr flush dev $INTERFACE
}

term_handler(){
    echo "Resseting interfaces"
    reset_interfaces
    echo "Stopping..."
    exit 0
}

# Setup signal handlers
trap 'term_handler' SIGTERM

echo "Starting..."

CONFIG_PATH=/data/options.json

SSID=$(jq --raw-output ".ssid" $CONFIG_PATH)
SSID_BROADCAST=$(jq --raw-output ".hide_ssid" $CONFIG_PATH)
WPA_PASSPHRASE=$(jq --raw-output ".wpa_passphrase" $CONFIG_PATH)
CHANNEL=$(jq --raw-output ".channel" $CONFIG_PATH)
BAND=$(jq --raw-output ".band" $CONFIG_PATH)
N=$(jq --raw-output ".wifi_n" $CONFIG_PATH)
HT40=$(jq --raw-output ".ht_40" $CONFIG_PATH)
ADDRESS=$(jq --raw-output ".address" $CONFIG_PATH)
NETMASK=$(jq --raw-output ".netmask" $CONFIG_PATH)
BROADCAST=$(jq --raw-output ".broadcast" $CONFIG_PATH)
INTERFACE=$(jq --raw-output ".hotspot_interface" $CONFIG_PATH)
COUNTRY=$(jq --raw-output ".country" $CONFIG_PATH)
ALLOW_INTERNET=$(jq --raw-output ".allow_internet" $CONFIG_PATH)
INTERNET_INTERFACE=$(jq --raw-output ".internet_interface" $CONFIG_PATH)
QOS=$(jq --raw-output ".qos" $CONFIG_PATH)
MAC=$(jq --raw-output ".allow_any_mac_address" $CONFIG_PATH)

DHCP_SERVER=$(jq --raw-output ".dhcp_enable" $CONFIG_PATH)
DHCP_START=$(jq --raw-output ".dhcp_start" $CONFIG_PATH)
DHCP_END=$(jq --raw-output ".dhcp_end" $CONFIG_PATH)
DHCP_DNS=$(jq --raw-output ".dhcp_dns" $CONFIG_PATH)
DHCP_SUBNET=$(jq --raw-output ".dhcp_subnet" $CONFIG_PATH)
DHCP_ROUTER=$(jq --raw-output ".dhcp_router" $CONFIG_PATH)

# Enforces required env variables
required_vars=(SSID WPA_PASSPHRASE CHANNEL ADDRESS NETMASK BROADCAST)
for required_var in "${required_vars[@]}"; do
    if [[ -z ${!required_var} ]]; then
        echo >&2 "Error: $required_var env variable not set."
        exit 1
    fi
done


INTERFACES_AVAILABLE="$(ifconfig -a | grep wl | cut -d ' ' -f '1')"
UNKNOWN=true

if [[ -z ${INTERFACE} ]]; then
        echo >&2 "Network interface not set. Please set one of the available:"
        echo >&2 "${INTERFACES_AVAILABLE}"
        exit 1
fi

for OPTION in ${INTERFACES_AVAILABLE}; do
    if [[ ${INTERFACE} == ${OPTION} ]]; then
        UNKNOWN=false
    fi 
done

if [[ ${UNKNOWN} == true ]]; then
        echo >&2 "Unknown network interface ${INTERFACE}. Please set one of the available:"
        echo >&2 "${INTERFACES_AVAILABLE}"
        exit 1
fi

echo "Set nmcli managed no"
nmcli dev set ${INTERFACE} managed no

echo "Network interface set to ${INTERFACE}"

# Configure iptables to enable/disable internet

RULE_3="POSTROUTING -o ${INTERNET_INTERFACE} -j MASQUERADE"
RULE_4="FORWARD -i ${INTERNET_INTERFACE} -o ${INTERFACE} -m state --state RELATED,ESTABLISHED -j ACCEPT"
RULE_5="FORWARD -i ${INTERFACE} -o ${INTERNET_INTERFACE} -j ACCEPT"

echo "Deleting iptables"
iptables -v -t nat -D $(echo ${RULE_3})
iptables -v -D $(echo ${RULE_4})
iptables -v -D $(echo ${RULE_5})

if test ${ALLOW_INTERNET} = true; then
    echo "Configuring iptables for NAT"
    iptables -v -t nat -A $(echo ${RULE_3})
    iptables -v -A $(echo ${RULE_4})
    iptables -v -A $(echo ${RULE_5})
fi


# Setup hostapd.conf
HCONFIG="/hostapd.conf"

echo "Setup hostapd ..."
echo "ssid=${SSID}" >> ${HCONFIG}
echo "wpa_passphrase=${WPA_PASSPHRASE}" >> ${HCONFIG}
echo "channel=${CHANNEL}" >> ${HCONFIG}
echo "hw_mode=${BAND}" >> ${HCONFIG}
if test ${N} = true
then
    echo "ieee80211n=1" >> ${HCONFIG}
else
    echo "ieee80211n=0" >> ${HCONFIG}
fi
if test ${QOS} = true
then
    echo "wmm_enabled=1" >> ${HCONFIG}
else
    echo "wmm_enabled=0" >> ${HCONFIG}
fi
if test ${HT40} = true
then
    echo "ht_capab=[HT40+][SHORT-GI-20][SHORT-GI-40]" >> ${HCONFIG}
fi
echo "interface=${INTERFACE}" >> ${HCONFIG}
if test ${SSID_BROADCAST} = true
then
    echo "ignore_broadcast_ssid=1" >> ${HCONFIG}
else
    echo "ignore_broadcast_ssid=0" >> ${HCONFIG}
fi
echo "country_code=${COUNTRY}" >> ${HCONFIG}
if test ${MAC} = true
then
    echo "macaddr_acl=1" >> ${HCONFIG}
else
    echo "macaddr_acl=0" >> ${HCONFIG}
fi
echo "" >> ${HCONFIG}

# Setup interface
IFFILE="/etc/network/interfaces"

echo "Setup interface ..."
echo "" > ${IFFILE}
echo "iface ${INTERFACE} inet static" >> ${IFFILE}
echo "  address ${ADDRESS}" >> ${IFFILE}
echo "  netmask ${NETMASK}" >> ${IFFILE}
echo "  broadcast ${BROADCAST}" >> ${IFFILE}
echo "" >> ${IFFILE}

echo "Resseting interfaces"
reset_interfaces
ifup ${INTERFACE}
sleep 1

if test ${DHCP_SERVER} = true; then
    # Setup hdhcpd.conf
    UCONFIG="/etc/udhcpd.conf"

    echo "Setup udhcpd ..."
    echo "interface    ${INTERFACE}"     >> ${UCONFIG}
    echo "start        ${DHCP_START}"    >> ${UCONFIG}
    echo "end          ${DHCP_END}"      >> ${UCONFIG}
    echo "opt dns      ${DHCP_DNS}"      >> ${UCONFIG}
    echo "opt subnet   ${DHCP_SUBNET}"   >> ${UCONFIG}
    echo "opt router   ${DHCP_ROUTER}"   >> ${UCONFIG}
    echo ""                              >> ${UCONFIG}

    echo "Starting DHCP server..."
    udhcpd -f &
fi

sleep 1

echo "Starting HostAP daemon ..."
hostapd ${HCONFIG} &

while true; do 
    echo "Interface stats:"
    ifconfig | grep ${INTERFACE} -A6
    sleep 3600
done
