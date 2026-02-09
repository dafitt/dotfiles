{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures Bluetooth support.";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # GUI
  environment.systemPackages = with pkgs; [ overskride ];
}
