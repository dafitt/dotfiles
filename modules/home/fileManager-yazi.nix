{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.dafitt.fileManager-yazi;
in
{
  options.dafitt.fileManager-yazi = with types; {
    setAsDefaultFileManager = mkEnableOption "making it the default file manager";

    autostart = mkOption {
      type = bool;
      default = cfg.setAsDefaultFileManager;
      description = "Whether to autostart at user login.";
    };
    workspace = mkOption {
      type = int;
      default = 3;
      description = "Which workspace is mainly to be used for this application.";
    };

    enablePlugins = mkOption {
      type = bool;
      default = true;
      description = "Whether to enable plugins.";
    };
  };

  config = mkMerge [
    {
      home.packages = with pkgs; [
        exiftool
      ];

      # [Documentation](https://yazi-rs.github.io/docs/quick-start/)
      programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableNushellIntegration = true;
        enableZshIntegration = true;

        settings.mgr.linemode = "size";

        keymap = {
          mgr.prepend_keymap = [
            {
              on = "q";
              run = "noop";
            }
            {
              on = "<C-q>";
              run = "quit";
              desc = "Quit yazi";
            }

            {
              on = "<C-c>";
              run = "noop";
            }
            {
              on = "<C-w>";
              run = "close";
              desc = "Close the current tab, or quit if it's the last";
            }
          ];
          mgr.append_keymap = [
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
              on = "<F2>";
              run = "rename --cursor=before_ext";
              desc = "Rename selected file(s)";
            }

            # bookmarks
            {
              on = [
                "g"
                "l"
              ];
              run = "cd ~/.local";
              desc = "Go to ~/.local";
            }
            {
              on = [
                "g"
                "r"
              ];
              run = "cd /";
              desc = "Go to /";
            }
          ];
          help.append_keymap = [
            {
              on = "<C-u>";
              run = "arrow -50%";
              desc = "Move cursor up half page";
            }
            {
              on = "<C-d>";
              run = "arrow 50%";
              desc = "Move cursor down half page";
            }
            {
              on = "<C-b>";
              run = "arrow -100%";
              desc = "Move cursor up one page";
            }
            {
              on = "<C-f>";
              run = "arrow 100%";
              desc = "Move cursor down one page";
            }
            {
              on = "<S-PageUp>";
              run = "arrow -50%";
              desc = "Move cursor up half page";
            }
            {
              on = "<S-PageDown>";
              run = "arrow 50%";
              desc = "Move cursor down half page";
            }
            {
              on = "<PageUp>";
              run = "arrow -100%";
              desc = "Move cursor up one page";
            }
            {
              on = "<PageDown>";
              run = "arrow 100%";
              desc = "Move cursor down one page";
            }
          ];
        };
      };

      # https://github.com/sxyazi/yazi/blob/main/assets/yazi.desktop
      xdg.desktopEntries.yazi = {
        name = "Yazi";
        genericName = "File Manager";
        comment = "Blazing fast terminal file manager written in Rust, based on async I/O";
        icon = builtins.fetchurl {
          url = "https://raw.githubusercontent.com/sxyazi/yazi/main/assets/logo.png";
          sha256 = "05crmd367v5915i553z172fsip6y8n8mvppjcpqxq9v7bml1vw3x";
        };
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
        bind = optionals cfg.setAsDefaultFileManager [
          "SUPER_ALT, F, exec, uwsm app -- ${getExe pkgs.kitty} -e ${getExe config.programs.yazi.package}"
        ];
        exec-once = optionals cfg.autostart [
          "[workspace ${toString cfg.workspace} silent] uwsm app -- ${getExe pkgs.kitty} -e ${getExe config.programs.yazi.package}"
        ];
      };
      programs.niri.settings = {
        binds."Mod+Alt+F" = mkIf cfg.setAsDefaultFileManager {
          action.spawn-sh = "uwsm app -- ${getExe pkgs.kitty} -e ${getExe config.programs.yazi.package}";
        };
        spawn-at-startup = optionals cfg.autostart [
          { sh = "uwsm app -- ${getExe pkgs.kitty} -e ${getExe config.programs.yazi.package}"; }
        ];
      };
    }

    (mkIf (cfg.enablePlugins) {
      home.packages = with pkgs; [
        ouch
        trash-cli
        wl-clipboard-rs
      ];

      programs.yazi = {
        plugins = with pkgs.yaziPlugins; {
          full-border = full-border; # https://github.com/yazi-rs/plugins/tree/main/full-border.yazi
          git = git; # https://github.com/yazi-rs/plugins/tree/main/git.yazi
          mount = mount; # https://github.com/yazi-rs/plugins/tree/main/mount.yazi
          ouch = ouch; # https://github.com/ndtoan96/ouch.yazi
          recycle-bin = recycle-bin; # https://github.com/uhs-robert/recycle-bin.yazi
          smart-enter = smart-enter; # https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi
          starship = starship; # https://github.com/Rolv-Apneseth/starship.yazi
          wl-clipboard = wl-clipboard; # https://github.com/grappas/wl-clipboard.yazi
        };

        initLua = concatStringsSep "\n" [
          ''require("full-border"):setup()''
          ''require("git"):setup()''
          ''require("recycle-bin"):setup()''
          ''require("starship"):setup()''
        ];

        settings.plugin = {
          prepend_fetchers = [
            # git
            {
              id = "git";
              name = "*";
              run = "git";
            }
            {
              id = "git";
              name = "*/";
              run = "git";
            }
          ];
          prepend_previewers = [
            # ouch
            {
              mime = "application/*zip";
              run = "ouch";
            }
            {
              mime = "application/x-tar";
              run = "ouch";
            }
            {
              mime = "application/x-bzip2";
              run = "ouch";
            }
            {
              mime = "application/x-7z-compressed";
              run = "ouch";
            }
            {
              mime = "application/x-rar";
              run = "ouch";
            }
            {
              mime = "application/vnd.rar";
              run = "ouch";
            }
            {
              mime = "application/x-xz";
              run = "ouch";
            }
            {
              mime = "application/xz";
              run = "ouch";
            }
            {
              mime = "application/x-zstd";
              run = "ouch";
            }
            {
              mime = "application/zstd";
              run = "ouch";
            }
            {
              mime = "application/java-archive";
              run = "ouch";
            }
          ];
        };

        keymap = {
          mgr.prepend_keymap = [
            # mount
            {
              on = "M";
              run = "plugin mount";
              desc = "Enter the mount menu";
            }

            # ouch
            {
              on = "C";
              run = "plugin ouch";
              desc = "Compress with ouch";
            }

            # recycle-bin
            {
              on = [
                "g"
                "t"
              ];
              run = "plugin recycle-bin open";
              desc = "Go to Trash";
            }
            {
              on = [
                "R"
                "o"
              ];
              run = "plugin recycle-bin open";
              desc = "Open Trash";
            }
            {
              on = [
                "R"
                "e"
              ];
              run = "plugin recycle-bin empty";
              desc = "Empty Trash";
            }
            {
              on = [
                "R"
                "d"
              ];
              run = "plugin recycle-bin delete";
              desc = "Delete from Trash";
            }
            {
              on = [
                "R"
                "D"
              ];
              run = "plugin recycle-bin emptyDays";
              desc = "Empty by days deleted";
            }
            {
              on = [
                "R"
                "r"
              ];
              run = "plugin recycle-bin restore";
              desc = "Restore from Trash";
            }

            # smart-enter
            {
              on = "<Enter>";
              run = "plugin smart-enter";
              desc = "Enter the child directory, or open the file";
            }

            # wl-clipboard
            {
              on = "<C-y>";
              run = "plugin wl-clipboard";
            }
          ];
        };
      };
    })
  ];
}
