# Check:
#$ nix flake check
#$ nix repl .#homeConfigurations.<user>[@<host>]

# Build:
#$ home-manager build .#<user>[@<host>]
#$ nix build .#homeConfigurations.<user>[@<host>].activationPackage

# Activate:
#$ home-manager switch .#<user>[@<host>]
#$ nix run .#homeConfigurations.<user>[@<host>].activationPackage

{ lib, ... }: with lib.dafitt; {

  dafitt = rec {
    #NOTE These are the defaults

    desktops.gnome.enable = osCfg.enable or true;

    desktops.hyprland.enable = osCfg.enable or false;
    desktops.hyprland.monitors = [ ]; # /modules/home/desktops/hyprland/monitors/default.nix
    desktops.hyprland.calculator.enable = desktops.hyprland.enable;
    desktops.hyprland.cliphist.enable = desktops.hyprland.enable;
    desktops.hyprland.fuzzel.enable = desktops.hyprland.enable;
    desktops.hyprland.gedit.enable = desktops.hyprland.enable;
    desktops.hyprland.hypridle.enable = desktops.hyprland.enable;
    desktops.hyprland.hypridle.timeouts.lock = 360;
    desktops.hyprland.hypridle.timeouts.suspend = 600;
    desktops.hyprland.hyprlock.enable = desktops.hyprland.enable;
    desktops.hyprland.hyprpaper.enable = desktops.hyprland.enable;
    desktops.hyprland.mako.enable = desktops.hyprland.enable;
    desktops.hyprland.pavucontrol.enable = desktops.hyprland.enable;
    desktops.hyprland.playerctl.enable = desktops.hyprland.enable;
    desktops.hyprland.plugins.enable = desktops.hyprland.enable;
    desktops.hyprland.swaybg.enable = false;
    desktops.hyprland.swayosd.enable = desktops.hyprland.enable;
    desktops.hyprland.top.enable = desktops.hyprland.enable;
    desktops.hyprland.waybar.enable = desktops.hyprland.enable;
    desktops.hyprland.wlsunset.enable = desktops.hyprland.enable;

    development.enableSuite = osCfg.enableSuite or false;
    development.installExtraPackages = development.enableSuite;
    development.direnv.enable = !osCfg.enable or development.enableSuite;
    development.git.enable = development.enableSuite;
    development.vscode.enable = development.enableSuite;
    development.vscode.autostart = true;
    development.vscode.defaultApplication = true;

    editing.enableSuite = osCfg.enableSuite or false;
    editing.installExtraPackages = editing.enableSuite;

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
    environment.kitty.enable = environment.enable;
    environment.mpv.enable = environment.enable;
    environment.mpv.defaultApplication = true;
    environment.syncthing.enable = environment.enable;
    environment.udiskie.enable = environment.enable;
    environment.xdg.enable = true;
    environment.xdg.mimeApps.enable = true;

    flatpak.enable = osCfg.enable or true;

    gaming.enableSuite = osCfg.enableSuite or false;
    gaming.installExtraPackages = gaming.enableSuite;
    gaming.steam.enable = osCfg.enable or gaming.enableSuite;

    music.enableSuite = osCfg.enableSuite or false;
    music.installExtraPackages = music.enableSuite;

    networking.connman.enable = osCfg.enable or false;

    office.enableSuite = osCfg.enableSuite or false;
    office.installExtraPackages = office.enableSuite;
    office.evince.enable = office.enableSuite;
    office.evince.defaultApplication = true;
    office.obsidian.enable = office.enableSuite;
    office.scribus.enable = office.enableSuite;
    office.thunderbird.enable = office.enableSuite;

    ricing.enableSuite = osCfg.enableSuite or false;
    ricing.installExtraPackages = ricing.enableSuite;

    shells.bash.enable = false;
    shells.fish.enable = osCfg.enable or false;
    shells.starship.enable = true;
    shells.zsh.enable = osCfg.enable or false;

    social.enableSuite = osCfg.enableSuite or false;
    social.installExtraPackages = social.enableSuite;

    virtualizaion.enableSuite = osCfg.enableSuite or false;
    virtualizaion.installExtraPackages = virtualizaion.enableSuite;
    virtualizaion.virt-manager.enable = osCfg.enable or false;

    web.enableSuite = osCfg.enableSuite or false;
    web.installExtraPackages = web.enableSuite;
    web.default = "librewolf"; # null or one of [ "epiphany" "firefox" "librewolf" ]
    web.autostart = true;
    web.epiphany.enable = web.enableSuite || web.default == "epiphany";
    web.firefox.enable = web.enableSuite || web.default == "firefox";
    web.librewolf.enable = web.enableSuite || web.default == "librewolf";
  };

  home.stateVersion = "23.11";
}
