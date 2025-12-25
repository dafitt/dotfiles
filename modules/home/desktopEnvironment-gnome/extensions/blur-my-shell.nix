{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions.blur-my-shell;
in
{
  options.dafitt.gnome.extensions.blur-my-shell = {
    enable = mkEnableOption "GNOME extension 'blur-my-shell'";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.gnomeExtensions; [ blur-my-shell ];

    dconf.settings = { };
  };
}
