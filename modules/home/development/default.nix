{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development;
  osCfg = osConfig.dafitt.development or null;
in
{
  options.dafitt.development = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the development suite";
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

    services.flatpak.packages = [
      { appId = "nl.hjdskes.gcolor3"; origin = "flathub"; }
      { appId = "com.belmoussaoui.ashpd.demo"; origin = "flathub"; }
    ];
  };
}
