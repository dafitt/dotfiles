{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.desktops.hyprland.mako;
  hyprlandCfg = config.wayland.windowManager.hyprland;
in
{
  options.dafitt.desktops.hyprland.mako = with types; {
    enable = mkBoolOpt config.dafitt.desktops.hyprland.enable "Enable mako for hyprland.";
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.libnotify ];

    # notification daemon
    #$ man 5 mako
    services.mako = {
      enable = true;
      anchor = "bottom-right";
      borderRadius = hyprlandCfg.settings.decoration.rounding;
      borderSize = hyprlandCfg.settings.general.border_size;
      borderColor = mkForce config.lib.stylix.colors.withHashtag.base0C;
      defaultTimeout = 5000;
      maxVisible = 10;
      format = "%a\\n%s\\n%b";
      sort = "+time";

      # padding/margin (like css): "<top>,<right>,<bottom>,<left>"
      extraConfig = ''
        outer-margin=${toString (hyprlandCfg.settings.general.gaps_out * 3)}

        [urgency=low]
        border-color=${config.lib.stylix.colors.withHashtag.base0D}
        text-color=${config.lib.stylix.colors.withHashtag.base0D}

        [urgency=high]
        border-color=${config.lib.stylix.colors.withHashtag.base08}
        text-color=${config.lib.stylix.colors.withHashtag.base08}
      '';
    };
    # last notification #$ makoctl restore
  };
}
