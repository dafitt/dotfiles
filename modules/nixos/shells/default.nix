{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.shells;
in
{
  # TODO: check if only one shell is enabled
  options.custom.shells = with types; {
    default = mkOpt package pkgs.fish "Which default shell to set";
  };

  config.users.defaultUserShell = cfg.default; # TODO: add config.programs.fish.package; upstream to nixpkgs
}
