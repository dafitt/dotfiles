{ inputs, ... }:

# Tuxedo
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.05";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      ./hardware-configuration.nix

      # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
      nixos-hardware.nixosModules.common-cpu-amd
      nixos-hardware.nixosModules.common-cpu-amd-pstate
      nixos-hardware.nixosModules.common-gpu-amd
      nixos-hardware.nixosModules.common-pc
      nixos-hardware.nixosModules.common-pc-ssd

      SHARED
      batteryOptimization
      bootloader-grub
      loginManager-gdm
    ];

  boot.loader.timeout = 10;

  hardware.tuxedo-rs = {
    enable = true;
    tailor-gui.enable = true;
  };
}
