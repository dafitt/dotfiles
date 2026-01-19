{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
{
  imports = with inputs; [ self.homeModules.stylix ];

  home.packages = with pkgs; [ nwg-drawer ];

  # https://github.com/nwg-piotr/nwg-drawer/blob/main/drawer.css
  xdg.configFile."nwg-drawer/drawer.css".text = with config.lib.stylix.colors; ''
    window {
        background-color: rgba(${base02-rgb-r}, ${base02-rgb-g}, ${base02-rgb-b}, 0.95);
        color: ${withHashtag.base05}
    }

    /* search entry */
    entry {
        background-color: rgba(0, 0, 0, 0.2)
    }

    button, image {
        background: none;
        border: none
    }

    button:hover {
        background-color: rgba(255, 255, 255, 0.1)
    }

    #category-button {
        margin: 0 10px 0 10px
    }

    #pinned-box {
        padding-bottom: 5px;
        border-bottom: 1px dotted gray
    }

    #files-box {
        padding: 5px;
        border: 1px dotted gray;
        border-radius: 15px
    }

    #math-label {
        font-weight: bold;
        font-size: 16px
    }
  '';

  wayland.windowManager.hyprland.settings = {
    bind = [
      "Super&Alt, Space, exec, uwsm app -- ${getExe pkgs.nwg-drawer} -ovl"
    ];
  };
  programs.niri.settings = {
    binds."Mod+Alt+Space" = {
      action.spawn-sh = "uwsm app -- ${getExe pkgs.nwg-drawer} -ovl";
    };
  };
}
