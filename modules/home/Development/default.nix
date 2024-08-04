{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development;
  osCfg = osConfig.dafitt.Development or null;
in
{
  options.dafitt.Development = with types; {
    enableSuite = mkBoolOpt (osCfg.enableSuite or false) "Enable the Development suite.";
  };

  config = mkIf cfg.enableSuite {
    home.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "FiraCode" "FiraMono" ]; })
      clang-tools # clangd for c/c++
      dig # tool for DNS
      fira-code-symbols # the ligatures aviable as symbols
      gcc # gnu c compiler
      gnome.gnome-nettool
      gucharmap # to search unicode characters
      gnumake # makefile
      httpie # a modern command line HTTP client
      mtr # better traceroute
      nil # nix language server
      nixpkgs-fmt # nix code formatter
      wev # tool for keyboard input
      yed # Drawing flowcharts
    ];

    services.flatpak.packages = [
      "com.belmoussaoui.ashpd.demo" # Play with portals
      "io.gitlab.liferooter.TextPieces" # Developer's scratchpad
      "nl.hjdskes.gcolor3"
    ];

    programs.firefox.profiles.${config.home.username}.extensions = with pkgs.nur.repos.rycee.firefox-addons; [
      github-file-icons
    ];
  };
}
