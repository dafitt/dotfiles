{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.yazi;
in
{
  options.dafitt.environment.yazi = with types; {
    enable = mkBoolOpt config.dafitt.environment.enable "Enable the yazi terminal file manager";
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
  };
}
