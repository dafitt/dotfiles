{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../../users/david.nix

    ./zfs.nix

    ../../common/DESKTOP.nix
    ../../common/gamemode.nix
  ];
}
