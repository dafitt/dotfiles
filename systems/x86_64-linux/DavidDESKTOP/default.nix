# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

{ ... }: {

  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix
  ];

  custom = {
    system = {
      bootloader.systemd-boot.enable = true;
      networking.networkmanager.enable = true;
    };

    desktops.gnome.enable = true;
    desktops.hyprland.enable = true;
    displayManager.gdm.enable = true;
    development.sshAgent.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    gaming.gamemode.enable = true;
    virtualization.virt-manager.enable = true;
  };

  system.stateVersion = "23.11";
}
