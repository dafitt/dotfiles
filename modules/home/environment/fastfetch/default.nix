{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.environment.fastfetch;
in
{
  options.dafitt.environment.fastfetch = with types; {
    enable = mkBoolOpt config.dafitt.environment.enable "Enable fastfetch";
  };

  config = mkIf cfg.enable {
    # https://github.com/fastfetch-cli/fastfetch/
    programs.fastfetch = {
      enable = true;
      settings = {
        logo = {
          separate = true;
        };
        display = {
          binaryPrefix = "si";
          color = {
            title = "green";
            keys = "yellow";
          };
        };
        modules = [
          # https://github.com/fastfetch-cli/fastfetch/blob/dev/presets/all.jsonc
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "display"
          "de"
          "wm"
          "wmtheme"
          "theme"
          "icons"
          "font"
          "cursor"
          "terminal"
          "terminalfont"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          "localip"
          "battery"
          "poweradapter"
          "locale"
          "break"
          "colors"
        ];
      };
    };

    home.shellAliases = {
      neofetch = "fastfetch";
    };

    home.packages = with pkgs; [
      python3 # required for fish shell's autocompletion
    ];
  };
}
