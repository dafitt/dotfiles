# test for home-manager
if ! which home-manager; then
    [[ "$(
        read -e -p 'Home-manager seems not to be installed. Installing? [y/N]> '
        echo $REPLY
    )" == [Yy]* ]] || exit

    #nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    #nix-channel --update

    # some error fixing
    sudo mkdir -m 755 -o $USER -g -p users /nix/var/nix/{profile,gcroots}/per-user/$USER

    # install home-manager and run the script again
    nix-shell --packages home-manager --run ./$(basename "$0")

    exit
fi

# override system configuration
rsync --archive --no-links --delete --progress -vh ./home/user/.config/home-manager/ ~/.config/home-manager

# rebuild home
if home-manager switch; then
    # update flake.lock in your directory
    cp --force ~/.config/home-manager/flake.lock ./home/user/.config/home-manager/
fi
