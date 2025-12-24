# Applying configurations on new machine
1. [Install](https://nixos.org/manual/nixos/stable/#sec-installation-manual)
1. `nixos-install --flake '/etc/nixos/flake.nix#ramikw'
1. `bash ./install.bash`

# Links

# Connecting to Wifi
1. `nmcli radio wifi on`
1. `nmcli dev wifi list`
1. `sudo nmcli dev wifi connect <network-ssid> password <network-password>`

For deleting existing Wifi: `nmcli connection delete "NameOfWifi"`
