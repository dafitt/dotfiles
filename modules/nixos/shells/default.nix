{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells;
in
{
  # TODO: check if only one shell is enabled
  options.dafitt.shells = with types; {
    default = mkOpt package pkgs.fish "Which default shell to set";
  };

  config.users.defaultUserShell = cfg.default; # TODO: add config.programs.fish.package; upstream to nixpkgs
}
