# Changelog

## [1.2.7]
- Bugfix

## [1.2.6]
### Added
- You can now toggle `40MHz` for `802.11n`

### Changed
- The default internet intefrace isn't specified by default
- The `allow_internet` option is now disabled by default

## [1.2.5]
### Changed
- Reverted to v1.2.2

## [1.2.4]
### Removed
- Toggling the `802.11b` option as it doesnt seem to be available in the `Alpine aarch64` version of `Hostapd`.

## [1.2.3]
### Added
- You can now toggle `802.11b`
- You can now choose between `AES` (`CCMP`) & `TKIP` authentication

### Changed
- The `WiFI N` option is now enabled by default
- The `WiFi B` option is now disabled by default

### Removed
- Useless comments from the `hostapd.conf` file

## [1.2.2]
### Added
- You can now allow any MAC addresses (useful for devices that use a "private MAC address")

## [1.2.1]
### Added
- You can now toggle `802.11n`
- You can now toggle QoS

## [1.2.0]
### Added
- You can now hide the broadcasted hotspot SSID
- You can now change the WiFi band (e.g. n/g)
- You can now change the interface used for the `allow_internet` option

### Changed
- The addon now requires you to specify your country to only allow using the WiFi channels approved in your country
- Rebranded from `hassio-hostapd-extended` to `hassio-hostapd-advanced`

## [1.1.0]
### Changed
- Add possibility to configure the DHCP and Hosapd settings for better customization of the access point
- Fix issue with enablind/disabling internet access not working before


## [1.0.11.5]
### Changed
- Removed the external DHCP addon from this repo

### Added
- Support for Atheros based Wifi dongles
- Settings to enable/disable internet access on the hotspot
- Settings to enable/disable a DHCP server on the hotspot

## [1.0.10]
### Changed
- Removed other addons from this repo
- Removed package versions from setup, to avoid new installs problem

### Added
- Possibility of setting the access point with USB Wifi dongles.

## [1.0.4 -> 1.0.9]
### Changed
- Versions used internally only, during development

## [1.0.3] -> This fork
### Fixed
- Update apk networkmanager and sudo in Dockefile. 

## [1.0.2]
### Fixed
- Disabled NetworkManager for wlan0 to prevent the addon stop working after a few minutes. 

## [1.0.1]
### Fixed
- Gracefully Stopping Docker Containers 

### Changed
- Apply Changelog Best Practices


## [1.0.0]
- Initial version