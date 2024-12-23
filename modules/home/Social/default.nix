{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Social;
  osCfg = osConfig.dafitt.Social or null;
in
{
  options.dafitt.Social = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Whether to enable the Social suite.";
  };

  config = mkIf cfg.enableSuite {
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
      bind = [ ];
      exec-once = [ ];
      windowrulev2 = [
        "float, class:whatsapp-desktop-linux, title:WhatsApp"
      ];
    };
  };
}
