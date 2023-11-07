NOW=$(date +%Y-%m-%d-%H%M)

# create backup folder if not exists
mkdir -p ./backup

# backup flake.lock
sudo cp /etc/nixos/flake.lock ./backup/etc.$HOSTNAME.$NOW.flake.lock
sudo chown $USER:users ./backup/etc.$HOSTNAME.$NOW.flake.lock

# delete flake.lock (just a move to fast-revert the update)
sudo mv /etc/nixos/flake.lock /etc/nixos/$NOW.flake.lock

# rebuild system
#if sudo nixos-rebuild test ; then # run switch manually if everything works fine
if sudo nixos-rebuild switch; then # will regenerate the new flake.lock file
    # update flake.lock in your directory
    sudo cp --force /etc/nixos/flake.lock ./etc/nixos/
    echo "System upgrade successfully completed!"
    # TODO ask to clean home nix?
else
    echo "System upgrade failed! Restoring original flake.lock..."

    # restore flake.lock
    sudo mv /etc/nixos/$NOW.flake.lock /etc/nixos/flake.lock
fi
