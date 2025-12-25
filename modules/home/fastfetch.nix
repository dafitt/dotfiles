{ pkgs, ... }:
{
  # https://github.com/fastfetch-cli/fastfetch/
  programs.fastfetch = {
    enable = true;
    settings = {
      logo = { };
      display = {
        size.binaryPrefix = "si";
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
        "bios"
        "board"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "lm"
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
        "vulkan"
        "opengl"
        "opencl"
        "memory"
        "swap"
        "disk"
        "publicip"
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
}
