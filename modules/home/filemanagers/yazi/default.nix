{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.filemanagers.yazi;
in
{
  options.dafitt.filemanagers.yazi = with types; {
    enable = mkEnableOption "terminal file manager 'yazi'";

    autostart = mkBoolOpt true "Whether to autostart at user login.";
    configureKeybindings = mkBoolOpt false "Whether to configure keybindings.";
  };

  config = mkIf cfg.enable {
    # [Documentation](https://yazi-rs.github.io/docs/quick-start/)
    programs.yazi = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };

    # https://github.com/sxyazi/yazi/blob/main/assets/yazi.desktop
    xdg.desktopEntries.yazi = {
      name = "Yazi";
      icon = ./logo.png;
      genericName = "File Manager";
      comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
      exec = ''${config.programs.yazi.package}/bin/yazi %u'';
      terminal = true;
      mimeType = [ "inode/directory" ];
      categories = [ "Utility" "Core" "System" "FileTools" "FileManager" "ConsoleOnly" ];

      settings = {
        TryExec = ''${config.programs.yazi.package}/bin/yazi'';
        Keywords = "File;Manager;Explorer;Browser;Launcher";
      };
    };

    wayland.windowManager.hyprland.settings = {
      bind = mkIf cfg.configureKeybindings [ "SUPER_ALT, F, exec, ${config.programs.yazi.package}/bin/yazi" ];
      exec-once = mkIf cfg.autostart [ "[workspace 2 silent] ${config.programs.yazi.package}/bin/yazi" ];
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
