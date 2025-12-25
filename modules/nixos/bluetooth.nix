{ pkgs, ... }:
{
  hardware.bluetooth.enable = true;

  # GUI
  environment.systemPackages = with pkgs; [ overskride ];
}
