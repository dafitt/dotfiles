# Host: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix

    ../../users/david.nix
    ../../users/guest.nix

    ../../common
    ../../common/displayManager.nix
    ../../common/flatpak.nix
    ../../common/gamemode.nix
    ../../common/GNOME.nix
    ../../common/Hyprland.nix
    ../../common/nix.nix
    ../../common/ssh.nix
    ../../common/steam.nix
    ../../common/virtualisation.nix
  ];
}
