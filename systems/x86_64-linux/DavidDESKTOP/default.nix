# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange

{
  #$ nix build .#nixosConfigurations.DavidDESKTOP.config.system.build.toplevel
  #$ nixos-rebuild build --flake .#DavidDESKTOP --show-trace
  #$ nixos-rebuild build-vm --flake .#DavidDESKTOP
  #$ sudo nixos-rebuild test --flake .#DavidDESKTOP
  #$ sudo nixos-rebuild boot --flake .#DavidDESKTOP
  #$ sudo nixos-rebuild switch --flake .#DavidDESKTOP


  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./zfs.nix
    ./miniDLNA.nix
  ];

  custom = {
    bootloader.systemd-boot.enable = true;
    desktops = {
      gnome.enable = true;
      hyprland.enable = true;
    };
    development.enableSuite = true;
    displayManager.gdm.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    gaming.gamemode.enable = true;
    networking.networkmanager.enable = true;
    syncthing.openFirewall = true;
    virtualization.virt-manager.enable = true;
  };
}
