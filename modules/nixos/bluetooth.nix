{ pkgs, ... }:
{
  meta.doc = "Enables and configures Bluetooth support.";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # GUI
  environment.systemPackages = with pkgs; [ overskride ];
}
