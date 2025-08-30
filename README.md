# Applying configurations on new machine
1. `sudo nixos-rebuild switch`
1. `bash ./install.bash`

# Links
- [Install](https://nixos.org/manual/nixos/stable/#sec-installation-manual)

# Connecting to Wifi
1. `nmcli radio wifi on`
1. `nmcli dev wifi list`
1. `sudo nmcli dev wifi connect network-ssid password "network-password"`

For deleting existing Wifi: `nmcli connection delete "NameOfWifi"`
