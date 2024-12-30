{ options, config, lib, pkgs, inputs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.gnome.extensions;
in
{
  options.dafitt.gnome.extensions = with types; {
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
      auto-move-windows.enable = true;
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
