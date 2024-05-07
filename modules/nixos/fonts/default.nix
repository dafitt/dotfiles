{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.fonts;
in
{
  options.dafitt.fonts = with types; {
    enable = mkBoolOpt true "Whether or not to manage fonts.";
    fonts = mkOpt (listOf package) [ ] "Custom font packages to install.";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      # Enable icons in tooling since we have nerdfonts.
      LOG_ICONS = "true";
    };

    environment.systemPackages = with pkgs; [ ];

    fonts.packages = with pkgs; [
      (nerdfonts.override {
        # https://www.nerdfonts.com/font-downloads
        # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerdfonts/shas.nix
        fonts = [
          "JetBrainsMono"
          "NerdFontsSymbolsOnly"
          "Noto"
          "Ubuntu"
          "UbuntuMono"
          # TODO: 24.05: "UbuntuSans"
        ];
      })
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
    ] ++ cfg.fonts;
  };
}
