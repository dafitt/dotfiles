{ config, lib, options, osConfig ? { }, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development;
  osCfg = osConfig.custom.development or null;
in
{
  options.custom.development = with types; {
    enableSuite = mkBoolOpt (osCfg.enable or false) "Enable the full development suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra development packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = [
      nixpkgs-fmt # nix code formatter
      gcc # gnu c compiler
      clang-tools # clangd for c/c++
      texlive.combined.scheme-full # for latex-workshop
    ];
  };
}
