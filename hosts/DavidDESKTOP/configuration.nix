{ pkgs, inputs, ... }:

# Case: Jonsbo T6 Black
# Mainboard: Asrock Z790 PG-ITX/TB4, Sockel 1700
# CPU: Intel I5 14600K + Thermalright Phantom Spirit 120 SE BLACK
# Memory: Crucial Pro DDR5 RAM 64GB Kit (2x32GB) 6000MHz CL40
# Disks:
#   - WD_BLACK SN7100 NVMe SSD 1TB
# Power Supply: Corsair SF750
# GPU: MSI Radeon RX560 4 GB
# GPU: AMD ATI Radeon RX 6650 XT
# Display:
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
      impermanance

      # https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
      nixos-hardware.nixosModules.common-cpu-intel
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd

      ./DavidBACKUP.nix

      SHARED
      bluetooth
      bootloader-limine
      development
      diskManagement
      gaming
      loginManager-greetd
      networking-networkmanager
      printing
      securityScan
      virtualization
    ];

  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  environment.persistence."/persist".files = [ "/etc/lact/config.yaml" ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  services.btrfs.autoScrub.enable = true;

  security.sudo-rs.wheelNeedsPassword = false;
}
