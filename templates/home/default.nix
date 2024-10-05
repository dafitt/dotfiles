# Check:
#$ nix flake check
#$ nixos-rebuild repl --fast --flake .#<host>
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

    bedtime.enable = false;

    bluetooth.enable = osCfg.enable or false;

    desktops.gnome.enable = osCfg.enable or false;
    desktops.gnome.extensions.enable = desktops.gnome.enable;
    desktops.gnome.extensions.app-icons-taskbar.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.appindicator.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.arcmenu.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.auto-move-windows.enable = false;
    desktops.gnome.extensions.blur-my-shell.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.forge.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.just-perfection.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.native-window-placement.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.openweather.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.paperwm.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.reorder-workspaces.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.rounded-window-corners.enable = false;
    desktops.gnome.extensions.search-light.enable = desktops.gnome.extensions.enable;
    desktops.gnome.extensions.vitals.enable = desktops.gnome.extensions.enable;

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
    desktops.hyprland.plugins.hycov.enable = false; # discontinued
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
    desktops.hyprland.udiskie.enable = desktops.hyprland.enable;
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

    editors.default = "micro"; # null or one of [ "micro" ]
    editors.micro.enable = editors.default == "micro";

    environment.enable = true;

    eog.enable = true;
    eog.defaultApplication = true;

    fastfetch.enable = true;

    file-roller.enable = true;
    file-roller.defaultApplication = true;

    filemanagers.default = "natuilus"; # null or one of [ "nautilus" "pcmanfm" "yazi" ]
    filemanagers.autostart = true;
    filemanagers.natuilus.enable = filemanagers.default == "natuilus";
    filemanagers.pcmanfm.enable = filemanagers.default == "pcmanfm";
    filemanagers.yazi.enable = filemanagers.default == "yazi";

    flatpak.enable = osCfg.enable or true;

    Gaming.enableSuite = osCfg.enableSuite or false;
    Gaming.steam.enable = Gaming.enableSuite;

    ianny.enable = false;

    imv.enable = true;

    launchers.default = "fuzzel"; # null or one of [ "fuzzel" "rofi" ]
    launchers.fuzzel.enalbe = desktops.hyprland.enable && launchers.default == "fuzzel";
    launchers.rofi.enalbe = desktops.hyprland.enable && launchers.default == "rofi";

    mpv.enable = true;
    mpv.defaultApplication = true;

    Music.enableSuite = osCfg.enableSuite or false;

    networking.connman.enable = osCfg.enable or false;
    networking.networkmanager.enable = osCfg.enable or false;

    Office.enableSuite = osCfg.enableSuite or false;
    Office.evince.enable = Office.enableSuite;
    Office.evince.defaultApplication = true;
    Office.obsidian.enable = Office.enableSuite;
    Office.scribus.enable = Office.enableSuite;
    Office.thunderbird.enable = Office.enableSuite;

    passwordManager.default = "bitwarden"; # null or one of [ "_1password" "bitwarden" ]
    passwordManager._1password.enable = passwordManager.default == "_1password";
    passwordManager.bitwarden.enable = passwordManager.default == "bitwarden";

    Ricing.enableSuite = osCfg.enableSuite or false;

    shells.bash.enable = false;
    shells.fish.enable = osCfg.enable or false;
    shells.starship.enable = true;
    shells.zsh.enable = osCfg.enable or false;

    Social.enableSuite = osCfg.enableSuite or false;

    syncthing.enable = true;

    systemd.enable = true;

    terminals.default = "kitty"; # one of [ "kitty" ]
    terminals.kitty.enable = terminals.default == "kitty";

    Virtualization.enableSuite = osCfg.enableSuite or false;
    Virtualization.virt-manager.enable = osCfg.enable or Virtualization.enableSuite;

    Web.enableSuite = osCfg.enableSuite or false;
    Web.default = "firefox"; # null or one of [ "epiphany" "firefox" "librewolf" ]
    Web.autostart = true;
    Web.epiphany.enable = Web.enableSuite || Web.default == "epiphany";
    Web.firefox.enable = Web.enableSuite || Web.default == "firefox";
    Web.librewolf.enable = Web.enableSuite || Web.default == "librewolf";

    xdg.enable = true;
    xdg.mimeApps.enable = true;
  };

  home.packages = with pkgs; [
  ];

  # add device-specific home configuration here #

  home.stateVersion = "24.05";
}
