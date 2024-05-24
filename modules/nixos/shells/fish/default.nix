{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells.fish;
in
{
  options.dafitt.shells.fish = with types; {
    enable = mkBoolOpt true "Enable fish shell.";
  };

  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      # also use objects provided by other packages
      vendor = {
        completions.enable = true;
        config.enable = true;
        functions.enable = true;
      };
    };
  };
}
