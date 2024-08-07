# Check:
#$ nix flake check
#$ nix repl
#nix-repl> :lf .
#nix-repl> nixosConfigurations.<host>.config.snowfallorg.users.<user>.home.config
#nix-repl> homeConfigurations.<user>[@<host>]

# Build:
#$ home-manager build .#<user>[@<host>]
#$ nix build .#homeConfigurations.<user>[@<host>].activationPackage

# Activate:
#$ home-manager switch .#<user>[@<host>]
#$ nix run .#homeConfigurations.<user>[@<host>].activationPackage

{ config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt; {
  imports = with inputs; [ ];

  dafitt = rec {
    #NOTE These values are the defaults

    bluetooth.enable = osCfg.enable or false;

    desktops.gnome.enable = osCfg.enable or false;

    desktops.hyprland.enable = osCfg.enable or false;
    desktops.hyprland.monitors = [ ]; # modules/home/desktops/hyprland/monitors/default.nix
    desktops.hyprland.calculator.enable = desktops.hyprland.enable;
    desktops.hyprland.cliphist.enable = desktops.hyprland.enable;
    desktops.hyprland.gedit.enable = desktops.hyprland.enable;
    desktops.hyprland.hypridle.enable = desktops.hyprland.enable;
    desktops.hyprland.hypridle.sleepTriggersLock = true;
    desktops.hyprland.hypridle.timeouts.lock = 360;
    desktops.hyprland.hypridle.timeouts.suspend = 600;
    desktops.hyprland.hyprlock.enable = desktops.hyprland.enable;
    desktops.hyprland.hyprpaper.enable = desktops.hyprland.enable;
    desktops.hyprland.notifications.hyprnotify.enable = desktops.hyprland.enable;
    desktops.hyprland.notifications.mako.enable = false;
    desktops.hyprland.nwg-displays.enable = desktops.hyprland.enable;
    desktops.hyprland.pavucontrol.enable = desktops.hyprland.enable;
    desktops.hyprland.playerctl.enable = desktops.hyprland.enable;
    desktops.hyprland.plugins.enable = desktops.hyprland.enable;
    desktops.hyprland.plugins.hycov.enable = desktops.hyprland.plugins.enable;
    desktops.hyprland.plugins.hypr-darkwindow.enable = false;
    desktops.hyprland.plugins.hypr-dynamic-cursors = false;
    desktops.hyprland.plugins.hyprexpo.enable = desktops.hyprland.plugins.enable;
    desktops.hyprland.plugins.hyprfocus.enable = false;
    desktops.hyprland.plugins.hyprnome.enable = false;
    desktops.hyprland.plugins.hyprspace.enable = false;
    desktops.hyprland.plugins.hyprsplit.enable = false;
    desktops.hyprland.plugins.hyprtrails.enable = false;
    desktops.hyprland.plugins.hyprwinwrap.enable = false;
    desktops.hyprland.pyprland.enable = desktops.hyprland.enable;
    desktops.hyprland.pyprland.scratchpads = { }; # modules/home/desktops/hyprland/pyprland/default.nix
    desktops.hyprland.ricing.enable = false;
    desktops.hyprland.ricing.wallpaper.enable = desktops.hyprland.ricing.enable;
    desktops.hyprland.swaybg.enable = false;
    desktops.hyprland.swayosd.enable = desktops.hyprland.enable;
    desktops.hyprland.top.enable = desktops.hyprland.enable;
    desktops.hyprland.waybar.enable = desktops.hyprland.enable;
    desktops.hyprland.wlsunset.enable = desktops.hyprland.enable;

    Development.enableSuite = osCfg.enableSuite or false;
    Development.direnv.enable = !osCfg.enable or Development.enableSuite;
    Development.git.enable = Development.enableSuite;
    Development.hyprland.enable = Development.enableSuite;
    Development.latex.enable = false;
    Development.vscode.enable = Development.enableSuite;
    Development.vscode.autostart = true;
    Development.vscode.defaultApplication = true;

    Editing.enableSuite = osCfg.enableSuite or false;

    environment.enable = true;
    environment._1password.enable = environment.enable;
    environment.bedtime.enable = environment.enable;
    environment.editors.default = "micro"; # null or one of [ "micro" ]
    environment.editors.micro.enable = environment.enable && environment.editor.default == "micro";
    environment.eog.enable = environment.enable;
    environment.eog.defaultApplication = true;
    environment.file-roller.defaultApplication = true;
    environment.file-roller.enable = environment.enable;
    environment.filemanagers.default = "natuilus"; # null or one of [ "nautilus" "pcmanfm" "yazi" ]
    environment.filemanagers.autostart = true;
    environment.filemanagers.natuilus.enable = environment.enable && environment.filemanagers.default == "natuilus";
    environment.filemanagers.pcmanfm.enable = environment.enable && environment.filemanagers.default == "pcmanfm";
    environment.filemanagers.yazi.enable = environment.enable && environment.filemanagers.default == "yazi";
    environment.imv.enable = environment.enable;
    environment.launchers.default = "fuzzel"; # null or one of [ "fuzzel" "rofi" ]
    environment.launchers.fuzzel.enalbe = desktops.hyprland.enable && environment.launchers.default == "fuzzel";
    environment.launchers.rofi.enalbe = desktops.hyprland.enable && environment.launchers.default == "rofi";
    environment.mpv.enable = environment.enable;
    environment.mpv.defaultApplication = true;
    environment.passwordManager.default = "bitwarden"; # null or one of [ "_1password" "bitwarden" ]
    environment.syncthing.enable = environment.enable;
    environment.terminals.default = "kitty"; # one of [ "kitty" ]
    environment.terminals.kitty.enable = environment.terminals.default == "kitty";
    environment.udiskie.enable = environment.enable;
    environment.xdg.enable = true;
    environment.xdg.mimeApps.enable = true;

    flatpak.enable = osCfg.enable or true;

    Gaming.enableSuite = osCfg.enableSuite or false;
    Gaming.steam.enable = Gaming.enableSuite;

    Music.enableSuite = osCfg.enableSuite or false;

    networking.connman.enable = osCfg.enable or false;

    Office.enableSuite = osCfg.enableSuite or false;
    Office.evince.enable = Office.enableSuite;
    Office.evince.defaultApplication = true;
    Office.obsidian.enable = Office.enableSuite;
    Office.scribus.enable = Office.enableSuite;
    Office.thunderbird.enable = Office.enableSuite;

    Ricing.enableSuite = osCfg.enableSuite or false;

    shells.bash.enable = false;
    shells.fish.enable = osCfg.enable or false;
    shells.starship.enable = true;
    shells.zsh.enable = osCfg.enable or false;

    Social.enableSuite = osCfg.enableSuite or false;

    systemd.enable = true;

    Virtualization.enableSuite = osCfg.enableSuite or false;
    Virtualization.virt-manager.enable = osCfg.enable or Virtualization.enableSuite;

    Web.enableSuite = osCfg.enableSuite or false;
    Web.default = "firefox"; # null or one of [ "epiphany" "firefox" "librewolf" ]
    Web.autostart = true;
    Web.epiphany.enable = Web.enableSuite || Web.default == "epiphany";
    Web.firefox.enable = Web.enableSuite || Web.default == "firefox";
    Web.librewolf.enable = Web.enableSuite || Web.default == "librewolf";
  };

  home.packages = with pkgs; [
  ];

  # add device-specific home configuration here #

  home.stateVersion = "24.05";
}
