{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  launchersCfg = config.dafitt.environment.launchers;
  cfg = launchersCfg.rofi;

  isDefault = launchersCfg.default == "rofi";
in
{
  options.dafitt.environment.launchers.rofi = with types; {
    enable = mkBoolOpt (config.dafitt.desktops.hyprland.enable && isDefault) "Enable the application launcher rofi";
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;

      terminal = config.home.sessionVariables.TERMINAL;
      extraConfig = {
        modi = "window,run,ssh,combi,keys,filebrowser,file-browser-extended,emoji,calc";
      };

      plugins = with pkgs; [
        rofi-bluetooth
        rofi-calc
        rofi-emoji
        rofi-file-browser
        rofi-power-menu
        rofi-systemd
      ];
    };

    #stylix.targets.rofi.enable = false;
    programs.rofi.theme = mkForce "custom"; # Use rofi-theme-selector for themes
    home.file.".config/rofi/themes/custom.rasi" = {
      force = true;
      text = ''
        // Colors
        * {
            bg0:    #272E33;
            bg1:    #2A2A2A;
            bg2:    #3D3D3D80;
            bg3:    #0b6495;
            fg0:    #E6E6E6;
            fg1:    #FFFFFF;
            fg2:    #969696;
            fg3:    #3D3D3D;
        }

        * {
            font:   "Roboto 12";

            background-color:   transparent;
            text-color:         @fg0;

            margin:     0px;
            padding:    0px;
            spacing:    0px;
        }

        window {
            location:       center;
            width:          480;
            border-radius:  24px;

            background-color:   @bg0;
        }

        mainbox {
            padding:    12px;
        }

        inputbar {
            background-color:   @bg1;
            border-color:       @bg3;

            border:         2px;
            border-radius:  16px;

            padding:    8px 16px;
            spacing:    8px;
            children:   [ prompt, entry ];
        }

        prompt {
            text-color: @fg2;
        }

        entry {
            placeholder:        "Search";
            placeholder-color:  @fg3;
        }

        message {
            margin:             12px 0 0;
            border-radius:      16px;
            border-color:       @bg2;
            background-color:   @bg2;
        }

        textbox {
            padding:    8px 24px;
        }

        listview {
            background-color:   transparent;

            margin:     12px 0 0;
            lines:      8;
            columns:    1;

            fixed-height: false;
        }

        element {
            padding:        8px 16px;
            spacing:        8px;
            border-radius:  16px;
        }

        element normal active {
            text-color: @bg3;
        }

        element selected normal, element selected active {
            background-color:   @bg3;
        }

        element-icon {
            size:           1em;
            vertical-align: 0.5;
        }

        element-text {
            text-color: inherit;
        }
      '';
    };

    wayland.windowManager.hyprland.settings = mkIf isDefault {
      bind = [ "SUPER, SPACE, exec, ${config.programs.rofi.package}/bin/rofi" ];
    };
  };
}
