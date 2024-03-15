{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development;
  osCfg = osConfig.custom.development or null;
in
{
  options.custom.development = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the full development suite";
    installExtraPackages = mkBoolOpt cfg.enableSuite "Install extra development packages";
  };

  config = mkIf cfg.installExtraPackages {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      clang-tools # clangd for c/c++
      dig # tool for DNS
      fira-code-symbols # the ligatures aviable as symbols
      gcc # gnu c compiler
      gnome.gnome-nettool
      gnome.gucharmap # to search unicode characters
      gnumake # makefile
      httpie # a modern command line HTTP client
      mtr # better traceroute
      nixpkgs-fmt # nix code formatter
      texlive.combined.scheme-full # for latex-workshop
      wev # tool for keyboard input
      yed # Drawing flowcharts
    ];
  };
}
