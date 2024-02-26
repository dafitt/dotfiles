{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.system.shell.fish;
in
{
  # TODO check if only one shell is enabled (mabe in system/shell/default.nix)
  options.custom.system.shell.fish = with types; {
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

    users.defaultUserShell = pkgs.fish; # TODO add config.programs.fish.package; upstream to nixpkgs
  };
}
