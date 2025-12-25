{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.gnome.extensions;
in
{
  imports = [
    extensions/app-icon-taskbar.nix
    extensions/appindicator.nix
    extensions/arcmenu.nix
    extensions/auto-move-windows.nix
    extensions/blur-my-shell.nix
    extensions/forge.nix
    extensions/just-perfection.nix
    extensions/native-window-placement.nix
    extensions/openweather.nix
    extensions/paperwm.nix
    extensions/reorder-workspaces.nix
    extensions/rounded-window-corners.nix
    extensions/search-light.nix
    extensions/vitals.nix
  ];

  options.dafitt.gnome.extensions = {
    enable = mkEnableOption "GNOME extensions";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gnome-extension-manager ];

    dconf.settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
      };
    };

    dafitt.gnome.extensions = mkDefault {
      app-icons-taskbar.enable = true;
      appindicator.enable = true;
      arcmenu.enable = true;
      blur-my-shell.enable = true;
      just-perfection.enable = true;
      native-window-placement.enable = true;
      paperwm.enable = true;
      reorder-workspaces.enable = true;
      search-light.enable = true;
      vitals.enable = true;
      # NOTE extensions must still be enabled manually.
    };
  };
}
