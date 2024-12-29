{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.starship;
in
{
  options.dafitt.starship = with types; {
    enable = mkEnableOption "the starship prompt";
  };

  config = mkIf cfg.enable {
    # A minimal, blazing fast, and extremely customizable prompt for any shell
    # https://starship.rs/
    programs.starship = {
      enable = true;

      settings = {
        # https://starship.rs/config
        cmd_duration = {
          format = "";
          min_time_to_notify = 450000;
          show_notifications = true;
        };
        #os.disabled = false;
        time = {
          disabled = false;
          format = "[$time]($style)";
          time_format = "%H:%M:%S ";
        };
      };
    };
  };
}
