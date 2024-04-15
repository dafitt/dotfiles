{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.social;
  osCfg = osConfig.dafitt.social or null;
in
{
  options.dafitt.social = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the social suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra social packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
    ];

    services.flatpak.packages = [
      { appId = "de.shorsh.discord-screenaudio"; origin = "flathub"; }
      { appId = "io.github.spacingbat3.webcord"; origin = "flathub"; }
      { appId = "org.gnome.Fractal"; origin = "flathub"; }
      { appId = "org.signal.Signal"; origin = "flathub"; }
      { appId = "io.github.mimbrero.WhatsAppDesktop"; origin = "flathub"; }
      { appId = "ch.threema.threema-web-desktop"; origin = "flathub"; }
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
