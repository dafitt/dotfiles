{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells;
in
{
  options.dafitt.shells = with types; {
    default = mkOpt (nullOr str) "fish" "Which default shell to set. The string needs to match the package name.";
  };

  config.users.defaultUserShell = mkIf (cfg.default != null) pkgs.${cfg.default}; #TODO add option config.programs.fish.package; upstream to nixpkgs
}
