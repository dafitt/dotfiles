{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix

    ../../users/david.nix
    ../../users/guest.nix

    ../../common/DESKTOP.nix
    ../../common/nix.nix
  ];
}
