# hassio-hostapd-advanced (forked from [joaofl](https://github.com/joaofl))

This addon allows creating an access point **with an optional DHCP server**, for your IoT devices using an internal WiFi card or an external USB WiFi dongle from brands like **Ralink & Atheros**.

### Configuration

The available configuration options are listed bellow. Make sure to edit them according to your needs:

```json
{
    "ssid": "WIFI_NAME",
    "hide_ssid": "false",
    "wpa_passphrase": "WIFI_PASSWORD",
    "aes": "true",
    "channel": "0",
    "band": "g",
    "wifi_n": true,
    "address": "192.168.4.1",
    "netmask": "255.255.255.0",
    "broadcast": "192.168.4.254",
    "hotspot_interface": "wlan1",
    "country": "US",
    "allow_internet": true,
    "internet_interface": "wlan0",
    "qos": true,
    "allow_any_mac_address": "false",
    "dhcp_server": true,
    "dhcp_start": "192.168.4.2",
    "dhcp_end": "192.168.4.199",
    "dhcp_dns": "1.1.1.1",
    "dhcp_subnet": "255.255.255.0",
    "dhcp_router": "192.168.4.1"
}

```

### Notes:

- When the channel is set to 0, the addon will automatically find the best channel.

- When the `interface` option is left blank, a list with the detected wlan interfaces will be printed in the log and the addon will terminate. Set the correct `interface` value on the configuration and then restart the addon.
