{ pkgs, inputs, ... }:

# Mainboard: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.11";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      ./hardware-configuration.nix

      disko.nixosModules.disko
      ./disk-configuration.nix

      # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd

      ./DavidBACKUP.nix
      ./miniDLNA.nix

      SHARED
      bluetooth
      bootloader-limine
      development
      gaming
      impermanance
      loginManager-greetd
      networking-networkmanager
      printing
      virtualization
    ];

  environment.systemPackages = with pkgs; [
    lact
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };

  services.btrfs.autoScrub.enable = true;

  security.sudo-rs.wheelNeedsPassword = false;
}
