{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # GUI
  environment.systemPackages = with pkgs; [ overskride ];
}
