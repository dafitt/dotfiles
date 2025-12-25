{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.auto-move-windows;
in
{
  options.dafitt.gnome.extensions.auto-move-windows = {
    enable = mkEnableOption "GNOME extension 'auto-move-windows'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ ];

    dconf.settings = {
      "org/gnome/shell/extensions/auto-move-windows" = {
        application-list = [
          "code.desktop:2"
          "codium.desktop:2"
          "md.obsidian.Obsidian.desktop:3"
          "com.logseq.Logseq.desktop:3"
          "org.gnome.Nautilus.desktop:4"
        ];
      };
    };
  };
}
