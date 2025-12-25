{ config, lib, ... }:
with lib;
let
  cfg = config.dafitt.desktopEnvironment-hyprland.plugins;
in
{
  imports = [
    plugins/hypr-darkwindow.nix
    plugins/hypr-dynamic-cursors.nix
    plugins/hyprexpo.nix
    plugins/hyprfocus.nix
    plugins/hyprnome.nix
    plugins/hyprspace.nix
    plugins/hyprsplit.nix
    plugins/hyprtrails.nix
    plugins/hyprwinwrap.nix
  ];

  options.dafitt.desktopEnvironment-hyprland.plugins = with types; {
    enable = mkEnableOption "plugins alltogether";
  };

  config = mkIf cfg.enable {
    dafitt.desktopEnvironment-hyprland.plugins = {
      hyprexpo.enable = true;
    };

    assertions = [
      {
        assertion =
          (count (option: option.enable) [
            cfg.hyprsplit
            cfg.hyprnome
          ]) < 2;
        message = "Only one of [ hyprsplit hyprnome ] in dafitt.desktopEnvironment-hyprland.plugins can be enabled at a time. Because they alter keybindings in a different way.";
      }
    ];
  };
}
