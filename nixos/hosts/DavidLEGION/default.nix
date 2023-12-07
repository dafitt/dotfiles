{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ../../users/david.nix

    ./power-management.nix

    ../../common/DESKTOP.nix
    ../../common/gamemode.nix
    ../../common/virtualisation.nix
  ];
}
