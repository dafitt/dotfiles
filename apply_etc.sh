# test for nixos
if ! which nixos-rebuild; then
    echo "No NixOS!" && exit 1
fi

# set rebuild mode to test as default
REBUILD_MODE="test"
if [ -n "$1" ]; then
    REBUILD_MODE="$1"
fi
echo "Doing a $REBUILD_MODE!"

# backup
if [ -f "/etc/nixos/configuration.nix" ]; then
    if ! [ -d "./backup" ]; then
        # create backup folder
        mkdir ./backup
    fi

    NOW=$(date +%Y-%m-%d-%H%M)
    # make backup of the system configuration
    sudo cp /etc/nixos/configuration.nix ./backup/$HOSTNAME\_$NOW.configuration.nix
    sudo chown $USER:users ./backup/$HOSTNAME\_$NOW.configuration.nix
fi

# copy the hardware config because it is going to be deleted
sudo cp /etc/nixos/hardware-configuration.nix ./etc/nixos/$HOSTNAME.hardware-configuration.nix
#sudo chown $USER:users ./etc/nixos/$HOSTNAME.*

# override system configuration
sudo rsync --archive --delete --progress -vh ./etc/nixos/ /etc/nixos
sudo chown -R root:root /etc/nixos
sudo find /etc/nixos -type f -exec chmod 644 {} +

# move hardware config back again
sudo mv ./etc/nixos/$HOSTNAME.hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo rm ./etc/nixos/$HOSTNAME.hardware-configuration.nix

# rebuild system
if sudo nixos-rebuild $REBUILD_MODE; then
    # update flake.lock in your directory
    sudo cp --force /etc/nixos/flake.lock ./etc/nixos/
fi
