# Hassio Hostapd Advanced

This addon allows creating an access point **with an optional DHCP server**, for your IoT devices using an internal WiFi card or an external USB WiFi dongle from brands like **Ralink & Atheros**.

## Configuration
**Note**: *Remember to restart the add-on when the configuration is changed.*

Example add-on configuration:

```yaml
ssid: WIFI_NAME,
hide_ssid: false,
wpa_passphrase: WIFI_PASSWORD
channel: 1
band: g
wifi_n: true
ht_40: false
address: 192.168.4.1
netmask: 255.255.255.0
broadcast: 192.168.4.254
hotspot_interface: wlan1
country: US
allow_internet: true
internet_interface: wlan0
qos: true
allow_any_mac_address: false
dhcp_server: true
dhcp_start: 192.168.4.2
dhcp_end: 192.168.4.199
dhcp_dns: 1.1.1.1
dhcp_subnet: 255.255.255.0
dhcp_router: 192.168.4.1
```

**Note**: *This is just an example, don't copy and paste it! Create your own!*

### Option: `ssid`

Specifies the name of the access point.

### Option: `hide_ssid`

Hides the SSID when enabled.

**Note**: *When this option is enabled, you won't see your access point in the WiFi networks list!*

### Option: `wpa_passphrase`

Specifies the password of the access point.

### Option: `channel`

Specifies the WiFi channel used for the access point.

**Note**: *When the channel is set to 0, the addon will automatically find the best channel.*

### Option: `band`

Specifies the WiFi frequency used for the access point.

**Note:** *Use `g` for **2.4GHz** or `a` for **5GHz** (if your adapter supports it).*

### Option: `wifi_n`

Enables/Disables `802.11n`.

### Option: `ht_40`

Enables/Disables `40MHz` (only broadcasts on `20MHz` when disabled and on both `40MHz` & `20MHz` when enabled).

**Note:** *This option may not work if there are too many 2.4GHz WiFi networks in your area or on the channel you chose (try to set a different WiFi channel).*

### Option: `address`

Specifies the address of the "router" (RPi/PC which runs this addon).

### Option: `netmask`

Specifies the Netmask used for the access point.

### Option: `broadcast`

Specifies the last IP that can be used on the access point.

### Option: `hotspot_interface`

Specifies the WiFi adapter that will be used to broadcast the access point.

**Note:** *When the `hotspot_interface` option is left blank, a list of the detected wlan interfaces will be printed in the log and the addon will terminate. Set the correct `hotspot_interface` value in the configuration and then restart the addon.*

### Option: `country`

Specifies the country the user lives in to only allow using the allowed WiFi bands for that country.

### Option: `allow_internet`

Enables/Disables internet access on the access point.

### Option: `internet_interface`

Specifies the interface that will be used for internet access (e.g. eth0 / wlan0).

**For example**: *If your RPi is connected to the internet using its onboard Ethernet port, set `eth0` as the `internet_interface` value.*

### Option: `qos`

Enables/Disables network Quality of service.

### Option: `allow_any_mac_address`

Allows devices that spoof their MAC address to connect to the access point (like the "Private Address" option on iOS).

### Option: `dhcp_server`

Enables/Disables the DHCP server used to assign IP addresses to connected WiFi clients automatically.

### Option: `dhcp_start`

Speficies the beginning of the DHCP IP range.

**Note**: *Always set the value of this option to at least one IP above the value you specified in the `address` option!*

**For example**: *If your `address` value is set to `192.168.4.1`, the DHCP start IP should be at least `192.168.4.2`.*

### Option: `dhcp_end`

Speficies the end of the DHCP IP range.

**Note**: *Don't set the value of this option to anything above the value you specified in the `broadcast` option!*

**For example**: *If your `broadcast` value is set to `192.168.4.254`, the DHCP end IP shouldn't be set to anything above `192.168.4.254`.*

### Option: `dhcp_dns`

Speficies the DNS server used for the access point.

**For example**: *`1.1.1.1` (CloudFlare's DNS) or `8.8.8.8` (Google's DNS).*

### Option: `dhcp_subnet`

Should match the value you specified in the `netmask` option.

### Option: `dhcp_router`

Should match the value you specified in the `address` option.