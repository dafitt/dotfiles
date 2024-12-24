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
    browsers.autostart = true;
    browsers.default = "firefox"; # null or one of [ "epiphany" "firefox" "librewolf" ]
    browsers.epiphany.enable = browsers.default == "epiphany";
    browsers.firefox.enable = browsers.default == "firefox";
    browsers.librewolf.enable = browsers.default == "librewolf";
    editors.default = "micro"; # null or one of [ "micro" ]
    editors.micro.enable = editors.default == "micro";
    environment.enable = true;
    eog.defaultApplication = true;
    eog.enable = true;
    fastfetch.enable = true;
    file-roller.defaultApplication = true;
    file-roller.enable = true;
    filemanagers.autostart = true;
    filemanagers.default = "natuilus"; # null or one of [ "nautilus" "pcmanfm" "yazi" ]
    filemanagers.natuilus.enable = filemanagers.default == "natuilus";
    filemanagers.pcmanfm.enable = filemanagers.default == "pcmanfm";
    filemanagers.yazi.enable = filemanagers.default == "yazi";
    flatpak.enable = osCfg.enable or true;
    gnome.enable = osCfg.enable or false;
    gnome.extensions.app-icons-taskbar.enable = gnome.extensions.enable;
    gnome.extensions.appindicator.enable = gnome.extensions.enable;
    gnome.extensions.arcmenu.enable = gnome.extensions.enable;
    gnome.extensions.auto-move-windows.enable = false;
    gnome.extensions.blur-my-shell.enable = gnome.extensions.enable;
    gnome.extensions.enable = gnome.enable;
    gnome.extensions.forge.enable = gnome.extensions.enable;
    gnome.extensions.just-perfection.enable = gnome.extensions.enable;
    gnome.extensions.native-window-placement.enable = gnome.extensions.enable;
    gnome.extensions.openweather.enable = gnome.extensions.enable;
    gnome.extensions.paperwm.enable = gnome.extensions.enable;
    gnome.extensions.reorder-workspaces.enable = gnome.extensions.enable;
    gnome.extensions.rounded-window-corners.enable = false;
    gnome.extensions.search-light.enable = gnome.extensions.enable;
    gnome.extensions.vitals.enable = gnome.extensions.enable;
    hyprland.calculator.enable = hyprland.enable;
    hyprland.cliphist.enable = hyprland.enable;
    hyprland.enable = osCfg.enable or false;
    hyprland.gedit.enable = hyprland.enable;
    hyprland.hypridle.enable = hyprland.enable;
    hyprland.hypridle.sleepTriggersLock = true;
    hyprland.hypridle.timeouts.lock = 360;
    hyprland.hypridle.timeouts.suspend = 600;
    hyprland.hyprlock.enable = hyprland.enable;
    hyprland.hyprpaper.enable = hyprland.enable;
    hyprland.monitors = [ ]; # modules/home/desktops/hyprland/monitors/default.nix
    hyprland.notifications.hyprnotify.enable = hyprland.enable;
    hyprland.notifications.mako.enable = false;
    hyprland.nwg-displays.enable = hyprland.enable;
    hyprland.pavucontrol.enable = hyprland.enable;
    hyprland.playerctl.enable = hyprland.enable;
    hyprland.plugins.enable = hyprland.enable;
    hyprland.plugins.hycov.enable = false; # discontinued
    hyprland.plugins.hypr-darkwindow.enable = false;
    hyprland.plugins.hypr-dynamic-cursors = false;
    hyprland.plugins.hyprexpo.enable = hyprland.plugins.enable;
    hyprland.plugins.hyprfocus.enable = false;
    hyprland.plugins.hyprnome.enable = false;
    hyprland.plugins.hyprspace.enable = false;
    hyprland.plugins.hyprsplit.enable = false;
    hyprland.plugins.hyprtrails.enable = false;
    hyprland.plugins.hyprwinwrap.enable = false;
    hyprland.pyprland.enable = hyprland.enable;
    hyprland.pyprland.scratchpads = { }; # modules/home/desktops/hyprland/pyprland/default.nix
    hyprland.ricing.enable = false;
    hyprland.ricing.wallpaper.enable = hyprland.ricing.enable;
    hyprland.swaybg.enable = false;
    hyprland.swayosd.enable = hyprland.enable;
    hyprland.top.enable = hyprland.enable;
    hyprland.udiskie.enable = hyprland.enable;
    hyprland.waybar.enable = hyprland.enable;
    hyprland.wlsunset.enable = hyprland.enable;
    ianny.enable = false;
    imv.enable = true;
    latex.enable = false;
    launchers.default = "fuzzel"; # null or one of [ "fuzzel" "rofi" ]
    launchers.fuzzel.enalbe = hyprland.enable && launchers.default == "fuzzel";
    launchers.rofi.enalbe = hyprland.enable && launchers.default == "rofi";
    mpv.defaultApplication = true;
    mpv.enable = true;
    networking.connman.enable = osCfg.enable or false;
    networking.networkmanager.enable = osCfg.enable or false;
    passwordManager._1password.enable = passwordManager.default == "_1password";
    passwordManager.bitwarden.enable = passwordManager.default == "bitwarden";
    passwordManager.default = "bitwarden"; # null or one of [ "_1password" "bitwarden" ]
    shells.bash.enable = false;
    shells.fish.enable = osCfg.enable or false;
    shells.starship.enable = true;
    shells.zsh.enable = osCfg.enable or false;
    steam.enable = false;
    suiteDevelopment.enable = osCfg.enable or false;
    suiteEditing.enable = osCfg.enable or false;
    suiteGaming.enable = osCfg.enable or false;
    suiteMusic.enable = osCfg.enable or false;
    suiteOffice.enable = osCfg.enable or false;
    suiteRicing.enable = osCfg.enable or false;
    suiteSocial.enable = osCfg.enable or false;
    suiteVirtualization.enable = osCfg.enable or false;
    suiteWeb.enable = osCfg.enable or false;
    syncthing.enable = true;
    systemd.enable = true;
    terminals.default = "kitty"; # one of [ "kitty" ]
    terminals.kitty.enable = terminals.default == "kitty";
    vscode.autostart = true;
    vscode.defaultApplication = true;
    vscode.enable = false;
    xdg.enable = true;
  };

  home.packages = with pkgs; [
  ];

  # add device-specific home configuration here #

  home.stateVersion = "24.05";
}
