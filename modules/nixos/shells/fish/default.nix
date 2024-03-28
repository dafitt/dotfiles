{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.shells.fish;
in
{
  options.custom.shells.fish = with types; {
    enable = mkBoolOpt true "Enable fish shell";
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
