{
  config,
  lib,
  pkgs,
  host,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.walker;
in
{
  options.dafitt.walker = with types; {
    enable = mkEnableOption "walker";
    setAsDefaultLauncher = mkEnableOption "making it the default launcher";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

    nix.settings = {
      substituters = [
        "https://walker-git.cachix.org"
        "https://walker.cachix.org"
      ];
      trusted-public-keys = [
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
      ];
    };

    programs.walker = {
      enable = true;
      runAsService = true;

      # All options from the config.json can be used here.
      config = {
        # https://github.com/abenz1267/walker/blob/master/internal/config/config.default.toml
        app_launch_prefix = "uwsm app -- ";
        disable_click_to_close = true;
        search.placeholder = host;
        ui.fullscreen = true;
        list = {
          height = 200;
        };
        websearch.prefix = "?";
        switcher.prefix = "/";
      };

      # If this is not set the default styling is used.
      theme = {
        #layout = {
        #  # https://github.com/abenz1267/walker/blob/master/internal/config/layout.default.toml
        #};
        ## https://github.com/abenz1267/walker/blob/master/internal/config/themes/default.css
        #style = ''
        #  * {
        #    color: #dcd7ba;
        #  }
        #'';
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultLauncher [
        "SUPER, SPACE, exec, ${config.programs.walker.package}/bin/walker"
      ];
    };
  };
}
