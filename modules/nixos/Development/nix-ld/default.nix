{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.nix-ld;
in
{
  options.dafitt.Development.nix-ld = with types; {
    enable = mkBoolOpt config.dafitt.Development.enableSuite "Allow running unpatched dynamic binaries on NixOS.";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };
}
