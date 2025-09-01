{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.yazi;
in
{
  options.dafitt.yazi = with types; {
    enable = mkEnableOption "yazi";
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkBoolOpt cfg.setAsDefaultFileManager "Whether to autostart at user login.";
    workspace = mkOpt int 3 "Which workspace is mainly to be used for this application.";
  };

  config = mkIf cfg.enable {
    # [Documentation](https://yazi-rs.github.io/docs/quick-start/)
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;

      keymap = {
        mgr.append_keymap = with config.xdg.userDirs; [
          {
            on = "T";
            run = "tab_close";
            desc = "Close current tab";
          }
          {
            on = "<C-h>";
            run = "hidden toggle";
            desc = "Toggle hidden files";
          }

          {
            on = [
              "g"
              "l"
            ];
            run = "cd ~/.local";
            desc = "Go to ~/.local";
          }
        ];
      };
    };

    # https://github.com/sxyazi/yazi/blob/main/assets/yazi.desktop
    xdg.desktopEntries.yazi = {
      name = "Yazi";
      genericName = "File Manager";
      comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
      icon = "yazi";
      exec = ''${config.programs.yazi.package}/bin/yazi %u'';
      terminal = true;
      type = "Application";
      categories = [
        "Utility"
        "Core"
        "System"
        "FileTools"
        "FileManager"
        "ConsoleOnly"
      ];
      mimeType = [ "inode/directory" ];

      settings = {
        TryExec = ''${config.programs.yazi.package}/bin/yazi'';
        Keywords = "File;Manager;Explorer;Browser;Launcher";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.setAsDefaultFileManager [
        "SUPER_ALT, F, exec, uwsm app -- ${config.programs.yazi.package}/bin/yazi"
      ];
      exec-once = mkIf cfg.autostart [
        "[workspace ${toString cfg.workspace} silent] uwsm app -- ${config.programs.yazi.package}/bin/yazi"
      ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.desktopItems = mkIf cfg.autostart {
      yazi = pkgs.makeDesktopItem {
        name = "yazi";
        desktopName = "Files";
        exec = "${config.programs.yazi.package}/bin/yazi";
      };
    };
  };
}
