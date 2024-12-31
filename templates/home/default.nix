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

  dafitt = {
    #NOTE These are the defaults that were taken from
    #$ nixos-rebuild --flake .#defaults repl
    #> :p config.snowfallorg.users.david.home.config.dafitt

    bedtime = { enable = false; };
    bluetooth = { enable = false; };
    browsers = {
      autostart = true;
      default = null;
      epiphany = { enable = false; };
      firefox = { enable = false; };
      librewolf = { enable = false; };
    };
    btop = { enable = false; };
    cava = { enable = false; };
    editors = {
      default = null;
      micro = { enable = false; };
    };
    enable = false;
    eog = {
      enable = false;
    };
    fastfetch = { enable = false; };
    file-roller = {
      enable = false;
    };
    filemanagers = {
      autostart = true;
      default = null;
      natuilus = { enable = false; };
      pcmanfm = { enable = false; };
      yazi = { enable = false; };
    };
    flatpak = { enable = false; };
    gedit = { enable = false; };
    gnome = {
      enable = false;
      extensions = {
        app-icons-taskbar = { enable = false; };
        appindicator = { enable = false; };
        arcmenu = { enable = false; };
        auto-move-windows = { enable = false; };
        blur-my-shell = { enable = false; };
        enable = false;
        forge = { enable = false; };
        just-perfection = { enable = false; };
        native-window-placement = { enable = false; };
        openweather = { enable = false; };
        paperwm = { enable = false; };
        reorder-workspaces = { enable = false; };
        rounded-window-corners = { enable = false; };
        search-light = { enable = false; };
        vitals = { enable = false; };
      };
    };
    gnome-calculator = { enable = false; };
    hyprland = {
      cliphist = { enable = false; };
      enable = false;
      hypridle = {
        enable = false;
        sleepTriggersLock = true;
        timeouts = {
          lock = 360;
          suspend = 600;
        };
      };
      hyprlock = { enable = false; };
      monitors = [ ];
      nwg-displays = { enable = false; };
      plugins = {
        enable = false;
        hycov = { enable = false; };
        hypr-darkwindow = { enable = false; };
        hypr-dynamic-cursors = { enable = false; };
        hyprexpo = { enable = false; };
        hyprfocus = { enable = false; };
        hyprnome = { enable = false; };
        hyprspace = { enable = false; };
        hyprsplit = { enable = false; };
        hyprtrails = { enable = false; };
        hyprwinwrap = { enable = false; };
      };
      pyprland = {
        enable = false;
        scratchpads = {
          networkmanager = {
            animation = "fromRight";
            class = "nm-connection-editor";
            command = "/nix/store/5r61rdwcnpgqzjxz28p7bfx6qnz7y0zp-network-manager-applet-1.36.0/bin/nm-connection-editor";
            lazy = true;
            margin = "2%";
            size = "40% 70%";
          };
        };
      };
      ricing = {
        enable = false;
        wallpaper = { enable = false; };
      };
      smartGaps = false;
      themes = {
        custom2023 = {
          enable = false;
          notifications = {
            hyprnotify = { enable = false; };
            mako = { enable = false; };
          };
          swayosd = { enable = false; };
          waybar = { enable = false; };
        };
        hyprpanel = { enable = false; };
      };
      ttyAutostart = true;
      wlsunset = { enable = false; };
    };
    ianny = { enable = false; };
    imv = { enable = false; };
    latex = { enable = false; };
    launchers = {
      default = null;
      fuzzel = { enable = false; };
      rofi = { enable = false; };
    };
    mpv = {
      enable = false;
    };
    networking = {
      connman = { enable = false; };
      networkmanager = { enable = false; };
    };
    passwordManagers = {
      _1password = { enable = false; };
      bitwarden = { enable = false; };
      default = null;
    };
    pavucontrol = { enable = false; };
    personalEnvironment = { enable = false; };
    playerctld = { enable = false; };
    shells = {
      bash = { enable = false; };
      fish = { enable = false; };
      zsh = { enable = false; };
    };
    starship = { enable = false; };
    steam = { enable = false; };
    stylix = { enable = false; };
    suiteDevelopment = { enable = false; };
    suiteEditing = { enable = false; };
    suiteGaming = { enable = false; };
    suiteMusic = { enable = false; };
    suiteOffice = { enable = false; };
    suiteRicing = { enable = false; };
    suiteSocial = { enable = false; };
    suiteVirtualization = { enable = false; };
    suiteWeb = { enable = false; };
    syncthing = { enable = false; };
    systemd = { enable = false; };
    terminals = {
      default = null;
      kitty = { enable = false; };
    };
    vscode = {
      autostart = true;
      enable = false;
      mkMutable = false;
    };
    xdg = { enable = false; };
  };

  home.packages = with pkgs; [
  ];

  # add device-specific home configuration here #

  home.stateVersion = "24.05";
}
