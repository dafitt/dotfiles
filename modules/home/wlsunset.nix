{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures wlsunset.";

  services.wlsunset = {
    enable = true;

    latitude = "48.0";
    longitude = "12.6";

    temperature = {
      day = 6500; # neutral: 6500K
      night = 4200;
    };
  };

  wayland.windowManager.hyprland.settings = {
    exec = [
      "${pkgs.systemd}/bin/systemctl restart --user wlsunset.service"
    ];
  };
}
