{ inputs, ... }:

#
# Mainboard:
# CPU:
# GPU:
# Memory:
# Case:
# Display:
# Camera:
# Battery:
# WIFI:
# Bluetooth:
# Color:
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.11";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      ./hardware-configuration.nix

      disko.nixosModules.disko
      impermanence.nixosModules.impermanence
      ./disk-configuration.nix

      SHARED
    ];
}
