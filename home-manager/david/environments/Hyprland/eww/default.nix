# credits to https://github.com/fufexan/dotfiles/blob/38c5af92d8767cd69f4ce30026e8be9022d2dbf1/home/services/eww/default.nix

{ config, pkgs, lib, inputs, ... }:
let
  dependencies = with pkgs; [
    cfg.package

    #inputs.gross.packages.${pkgs.system}.gross
    config.wayland.windowManager.hyprland.package

    # Fonts
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    (callPackage ../../../../../pkgs/phosphoricons { })

    ripgrep # recursive directory regex grep

    # Hyprland workspaces widget
    jq # JSON processor
    socat
    # Music control
    playerctl

    #bash
    #blueberry
    #bluez
    #brillo
    #coreutils
    #dbus
    #findutils
    #gawk
    #gnome.gnome-control-center
    #gnused
    #imagemagick
    #jaq
    #jc
    #libnotify
    #networkmanager
    #pavucontrol
    #playerctl
    #procps
    #pulseaudio
    #socat
    #udev
    #upower
    #util-linux
    #wget
    #wireplumber
    #wlogout
  ];

  startupScript = pkgs.writeShellScript "eww-startup" ''
    ${cfg.package}/bin/eww open background
    ${cfg.package}/bin/eww open workspaces
    ${cfg.package}/bin/eww open clock
    ${cfg.package}/bin/eww open usersettings
    ${cfg.package}/bin/eww open systeminfo
    ${cfg.package}/bin/eww open powermenu

    if [ -n "$(ls -A /sys/class/backlight 2>/dev/null)" ]; then
      ${cfg.package}/bin/eww update brightness=true
      ${cfg.package}/bin/eww update brightness_percent=$(light)
    fi
    ${cfg.package}/bin/eww update microphone_mute=$(if [ \"$(wpctl get-volume @DEFAULT_SOURCE@ | cut -d ' ' -f3)\" = '[MUTED]' ]; then echo true; else echo false; fi)
    ${cfg.package}/bin/eww update microphone_volume_percent=$(wpctl get-volume @DEFAULT_SOURCE@ | tr -d 'Volume: ' | tr -d '[MUTED]')
    ${cfg.package}/bin/eww update audio_mute=$(if [ \"$(wpctl get-volume @DEFAULT_SINK@ | cut -d ' ' -f3)\" = '[MUTED]' ]; then echo true; else echo false; fi)
    ${cfg.package}/bin/eww update audio_volume_percent=$(wpctl get-volume @DEFAULT_SINK@ | tr -d 'Volume: ' | tr -d '[MUTED]')
  '';

  cfg = config.programs.eww-personal;
in
{
  options.programs.eww-personal = {
    enable = lib.mkEnableOption "Personal eww Hyprland config";

    package = lib.mkOption {
      type = with lib.types; nullOr package;
      default = pkgs.eww-wayland;
      defaultText = lib.literalExpression "pkgs.eww-wayland";
      description = "Eww package to use.";
    };

    manualSymlinked = lib.mkOption {
      type = lib.types.bool;
      default = false;
      defaultText = "false";
      description = ''
        If you have manually symlinked the eww config files to the current repositories eww directory,
        e.g. `ln -s ~/Desktop/NixOS/home-manager/david/configurations/Hyprland/eww/ ~/.config`.
        This is useful if you dont want to rebuild to apply eww-changes. Intended for development.
        Home-manager will not override .config/eww if this is set to true.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = dependencies;

    xdg.configFile."eww" = lib.mkIf (!cfg.manualSymlinked) {
      source = lib.cleanSourceWith {
        # remove nix files
        filter = name: _type:
          let
            baseName = baseNameOf (toString name);
          in
            !(lib.hasSuffix ".nix" baseName);
        src = lib.cleanSource ./.;
      };

      # links each file individually, which lets us insert the colors file separately
      recursive = true;
    };

    # color files (get from stylix)
    xdg.configFile = {
      "eww/css/colors.scss".text = ''
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
      "eww/css/colors.yuck".text = ''
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

    systemd.user.services.eww = {
      Unit = {
        Description = "Eww Daemon";
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Environment = "PATH=/run/wrappers/bin:${lib.makeBinPath dependencies}";
        ExecStart = "${cfg.package}/bin/eww daemon --no-daemonize";
        ExecStartPost = startupScript.outPath;
        ExecReload = "${cfg.package}/bin/eww reload";
        ExecStop = "${cfg.package}/bin/eww kill";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
