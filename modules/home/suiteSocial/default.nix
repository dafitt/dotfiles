{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteSocial;
  osCfg = osConfig.dafitt.suiteSocial or null;
in
{
  options.dafitt.suiteSocial = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Social suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
    ];

    services.flatpak.packages = [
      "io.github.spacingbat3.webcord"
      "org.gnome.Fractal"
      "org.signal.Signal"
      "io.github.mimbrero.WhatsAppDesktop"
      "ch.threema.threema-web-desktop"
    ];

    wayland.windowManager.hyprland.settings = {
      windowrule = [
        "float, class:whatsapp-desktop-linux, title:WhatsApp"
      ];
    };
  };
}
