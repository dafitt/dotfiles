# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

{ pkgs, path, ... }: {

  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix

    "${path.nixosDir}/users/david.nix"
    #"${path.nixosDir}/users/guest.nix"
    "${path.nixosDir}/users/root.nix"

    "${path.nixosDir}/common"
    "${path.nixosDir}/common/displayManager.nix"
    "${path.nixosDir}/common/flatpak.nix"
    "${path.nixosDir}/common/gamemode.nix"
    "${path.nixosDir}/common/GNOME.nix"
    "${path.nixosDir}/common/Hyprland.nix"
    "${path.nixosDir}/common/nix.nix"
    "${path.nixosDir}/common/ssh.nix"
    "${path.nixosDir}/common/steam.nix"
    "${path.nixosDir}/common/virtualisation.nix"
  ];

  system.stateVersion = "23.05"; # Do not touch
}
