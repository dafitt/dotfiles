{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the NetworkManager network manager on your system.";

  networking.networkmanager.enable = true;

  programs.nm-applet.enable = true;

  # GTK GUI for NetworkManager
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
