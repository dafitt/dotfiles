#$ home-manager build .[#<name>]
#$ home-manager switch .[#<name>]
{ lib, ... }: with lib.dafitt; {

  dafitt = rec {
    #NOTE These are the defaults

    desktops.common.enable = true;
    desktops.common._1password.enable = desktops.common.enable;
    desktops.common.bedtime.enable = desktops.common.enable;
    desktops.common.eog.enable = desktops.common.enable;
    desktops.common.eog.defaultApplication = true;
    desktops.common.file-roller.enable = desktops.common.enable;
    desktops.common.file-roller.defaultApplication = true;
    desktops.common.imv.enable = desktops.common.enable;
    desktops.common.kitty.enable = desktops.common.enable;
    desktops.common.micro.enable = desktops.common.enable;
    desktops.common.mpv.enable = desktops.common.enable;
    desktops.common.mpv.defaultApplication = true;
    desktops.common.natuilus.enable = desktops.common.enable;
    desktops.common.natuilus.autostart = true;
    desktops.common.pcmanfm.enable = false;
    desktops.common.syncthing.enable = desktops.common.enable;
    desktops.common.udiskie.enable = desktops.common.enable;
    desktops.common.yazi.enable = desktops.common.enable;

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
    web.epiphany.enable = web.enableSuite;
    web.firefox.enable = web.enableSuite;
    web.firefox.autostart = false;
    web.firefox.defaultApplication = false;
    web.librewolf.enable = web.enableSuite;
    web.librewolf.autostart = true;
    web.librewolf.defaultApplication = true;

    xdg.enable = true;
    xdg.mimeApps.enable = true;
  };

  home.stateVersion = "23.11";
}
