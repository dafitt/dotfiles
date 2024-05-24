{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.nix-ld;
in
{
  options.dafitt.development.nix-ld = with types; {
    enable = mkBoolOpt config.dafitt.development.enableSuite "Allow running unpatched dynamic binaries on NixOS.";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged
      # programs here, NOT in environment.systemPackages
    ];
  };
}
