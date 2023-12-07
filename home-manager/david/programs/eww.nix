{ pkgs, config, ... }: {

  # ElKowar's Wacky Widgets
  # https://github.com/elkowar/eww
  programs.eww = {
    # eww guide https://dharmx.is-a.dev/eww-powermenu/
    # configuration doc <https://elkowar.github.io/eww/configuration.html>
    # widgets doc <https://elkowar.github.io/eww/widgets.html>
    # a good example <https://github.com/end-4/dots-hyprland/tree/m3ww>

    # set symlink manually $ ln -s ~/Desktop/NixOS/home-manager/david/modules/eww ~/.config/

    enable = true;
    package = pkgs.eww-wayland;
    configDir = ../modules/eww;
  };

  home.packages = with pkgs; [
    eww-wayland

    # fonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    (callPackage ../pkgs/phosphoricons { }) # <https://phosphoricons.com/>

    # dependency: Hyprland workspaces widget
    socat
    jq
    # dependency: music control
    playerctl
  ];

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "$XDG_CONFIG_HOME/eww/startup"

      # TODO "blueman-applet"
      # TODO "nm-applet --indicator"
    ];
    exec = [
      "$XDG_CONFIG_HOME/eww/startup"
    ];
  };

  # hand stylix colors to eww
  home.file = {
    ".config/eww/css/colors.scss".text = ''
      $base00: #${config.lib.stylix.colors.base00}; // base
      $base01: #${config.lib.stylix.colors.base01}; // mantle
      $base02: #${config.lib.stylix.colors.base02}; // surface0
      $base03: #${config.lib.stylix.colors.base03}; // surface1
      $base04: #${config.lib.stylix.colors.base04}; // surface2
      $base05: #${config.lib.stylix.colors.base05}; // text
      $base06: #${config.lib.stylix.colors.base06}; // rosewater
      $base07: #${config.lib.stylix.colors.base07}; // lavender1
      $base08: #${config.lib.stylix.colors.base08}; // red
      $base09: #${config.lib.stylix.colors.base09}; // peach
      $base0A: #${config.lib.stylix.colors.base0A}; // yellow
      $base0B: #${config.lib.stylix.colors.base0B}; // green
      $base0C: #${config.lib.stylix.colors.base0C}; // teal
      $base0D: #${config.lib.stylix.colors.base0D}; // blue
      $base0E: #${config.lib.stylix.colors.base0E}; // mauve
      $base0F: #${config.lib.stylix.colors.base0F}; // flamingo
    '';
    ".config/eww/css/colors.yuck".text = ''
      (defvar base00 "#${config.lib.stylix.colors.base00}") ; base
      (defvar base01 "#${config.lib.stylix.colors.base01}") ; mantle
      (defvar base02 "#${config.lib.stylix.colors.base02}") ; surface0
      (defvar base03 "#${config.lib.stylix.colors.base03}") ; surface1
      (defvar base04 "#${config.lib.stylix.colors.base04}") ; surface2
      (defvar base05 "#${config.lib.stylix.colors.base05}") ; text
      (defvar base06 "#${config.lib.stylix.colors.base06}") ; rosewater
      (defvar base07 "#${config.lib.stylix.colors.base07}") ; lavender
      (defvar base08 "#${config.lib.stylix.colors.base08}") ; red
      (defvar base09 "#${config.lib.stylix.colors.base09}") ; peach
      (defvar base0A "#${config.lib.stylix.colors.base0A}") ; yellow
      (defvar base0B "#${config.lib.stylix.colors.base0B}") ; green
      (defvar base0C "#${config.lib.stylix.colors.base0C}") ; teal
      (defvar base0D "#${config.lib.stylix.colors.base0D}") ; blue
      (defvar base0E "#${config.lib.stylix.colors.base0E}") ; mauve
      (defvar base0F "#${config.lib.stylix.colors.base0F}") ; flamingo
    '';
  };
}
