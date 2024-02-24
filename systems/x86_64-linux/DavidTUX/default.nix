{ path, ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix

    "${path.nixosDir}/users/david.nix"
    "${path.nixosDir}/users/guest.nix"

    "${path.nixosDir}/common/connman.nix"
    "${path.nixosDir}/common/DESKTOP.nix"
    "${path.nixosDir}/common/nix.nix"
  ];

  system.stateVersion = "23.05"; # Do not touch
}
