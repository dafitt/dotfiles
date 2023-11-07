NOW=$(date +%Y-%m-%d-%H%M)

# create backup folder if not exists
mkdir -p ./backup

# backup flake.lock
cp ~/.config/home-manager/flake.lock ./backup/home.$USER.$NOW.flake.lock

# delete flake.lock (just a move to fast-revert the update)
mv ~/.config/home-manager/flake.lock ~/.config/home-manager/$NOW.flake.lock

# rebuild home
if home-manager switch; then # will regenerate the new flake.lock file
    # update flake.lock in your directory
    cp --force ~/.config/home-manager/flake.lock ./home/user/.config/home-manager/

    echo "Home upgrade successfully completed!"
    # TODO ask to clean home nix?
else
    echo "System upgrade failed! Restoring original flake.lock..."

    # restore flake.lock
    mv ~/.config/home-manager/$NOW.flake.lock ~/.config/home-manager/flake.lock

    exit 1
fi
