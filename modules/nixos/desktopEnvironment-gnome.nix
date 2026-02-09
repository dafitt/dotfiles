{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the GNOME desktop environment on your system.";

  services.desktopManager.gnome.enable = true;
  services.udev.packages = [ pkgs.gnome-settings-daemon ];

  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];
}
