{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.cava;
in
{
  options.dafitt.cava = with types; {
    enable = mkEnableOption "cava, a console-based Audio Visualizer";
  };

  config = mkIf cfg.enable {
    dafitt.stylix.enable = true;

    programs.cava = {
      enable = true;
      settings = {
        # https://github.com/karlstav/cava/blob/master/example_files/config
        general = {
          sleep_timer = 60;
        };
        smoothing.noise_reduction = 48;
        color = {
          gradient = 1;
          gradient_count = 8;
          gradient_color_1 = "'${config.lib.stylix.colors.withHashtag.base00}'";
          gradient_color_2 = "'${config.lib.stylix.colors.withHashtag.base0D}'";
          gradient_color_3 = "'${config.lib.stylix.colors.withHashtag.base0C}'";
          gradient_color_4 = "'${config.lib.stylix.colors.withHashtag.base0B}'";
          gradient_color_5 = "'${config.lib.stylix.colors.withHashtag.base0B}'";
          gradient_color_6 = "'${config.lib.stylix.colors.withHashtag.base0A}'";
          gradient_color_7 = "'${config.lib.stylix.colors.withHashtag.base09}'";
          gradient_color_8 = "'${config.lib.stylix.colors.withHashtag.base08}'";
        };
      };
    };
  };
}
