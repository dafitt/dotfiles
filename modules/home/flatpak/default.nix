{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.flatpak;
  osCfg = osConfig.custom.flatpak or null;
in
{
  options.custom.flatpak = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable flatpak support";
  };

  config = mkIf cfg.enable
    {
      # find flatpaks .desktop binary paths
      # $PATH
      home.sessionPath = [
        "$HOME/.local/share/flatpak/exports/share"
      ];
      # $XDG_DATA_DIRS
      xdg.systemDirs.data = [
        "$HOME/.local/share/flatpak/exports/share"
      ];

      home.shellAliases = {
        flatpak-install = "flatpak install --user --or-update --assumeyes";
      };

      wayland.windowManager.hyprland.settings = {
        bind = [ ];
        exec-once = [
          # [fix for flatpak open URLs with default browser](https://discourse.nixos.org/t/open-links-from-flatpak-via-host-firefox/15465/11)
          "${pkgs.systemd}/bin/systemctl --user import-environment PATH && ${pkgs.systemd}/bin/systemctl --user restart xdg-desktop-portal.service"

          "[workspace 3 silent;noinitialfocus] ${pkgs.flatpak}/bin/flatpak run md.obsidian.Obsidian"
        ];
        exec = [ ];
        windowrulev2 = [
          "bordercolor rgb(1887d8), class:steam"
          "float, class:steam, title:(Friends List)|(Settings)"
          "float, class:whatsapp-desktop-linux, title:WhatsApp"
        ];
      };
    };
}
