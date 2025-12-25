{ pkgs, ... }:
{
  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;

  # GTK GUI for NetworkManager
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
