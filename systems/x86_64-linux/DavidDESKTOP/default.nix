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
  ];

  cutsom = {
    system = {
      boot.systemd-boot.enable = true;
      networking.networkmanager.enable = true;
    };

    features = {
      desktops.gnome.enable = true;
      desktops.hyprland.enable = true;
      flatpak.enable = true;
      fwupd.enable = true;
      gamemode.enable = true;
      displayManager.gdm.enable = true;
      sshAgent.enable = true;
      virtualization.virt-manager.enable = true;
    };
  };

  system.stateVersion = "23.11";
}
