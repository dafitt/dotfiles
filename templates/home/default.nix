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
      default = "firefox";
      epiphany = { enable = false; };
      firefox = { enable = true; };
      librewolf = { enable = false; };
    };
    btop = { enable = true; };
    cava = { enable = false; };
    editors = {
      default = "micro";
      micro = { enable = true; };
    };
    eog = {
      defaultApplication = true;
      enable = true;
    };
    fastfetch = { enable = true; };
    file-roller = {
      defaultApplication = true;
      enable = true;
    };
    filemanagers = {
      autostart = true;
      default = "nautilus";
      natuilus = { enable = true; };
      pcmanfm = { enable = false; };
      yazi = { enable = false; };
    };
    flatpak = { enable = false; };
    gedit = { enable = true; };
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
          btop = {
            animation = "fromTop";
            class = "btop";
            command = "/nix/store/sd4fvqvmgvvmmrk5q1l8lcsmzcfiqs2c-kitty-0.37.0/bin/kitty --class btop /nix/store/8gab83bb1vn2v6haibhzfx549rplm8ps-btop-1.4.0/bin/btop";
            lazy = true;
            margin = "2%";
            size = "90% 90%";
          };
          kitty = {
            animation = "fromTop";
            class = "dropterm";
            command = "/nix/store/sd4fvqvmgvvmmrk5q1l8lcsmzcfiqs2c-kitty-0.37.0/bin/kitty --class dropterm --hold /nix/store/6pqn4fnrcdy46dcsgf2r1pw7cffx7lfd-fastfetch-2.31.0/bin/fastfetch";
            lazy = true;
            margin = "2%";
            size = "90% 90%";
          };
          networkmanager = {
            animation = "fromRight";
            class = "nm-connection-editor";
            command = "/nix/store/5r61rdwcnpgqzjxz28p7bfx6qnz7y0zp-network-manager-applet-1.36.0/bin/nm-connection-editor";
            lazy = true;
            margin = "2%";
            size = "40% 70%";
          };
          pavucontrol = {
            animation = "fromRight";
            class = "pavucontrol";
            command = "/nix/store/mn9nzv78nwxkdq5clflcx748k5jcw01x-pavucontrol-6.1/bin/pavucontrol";
            lazy = true;
            margin = "2%";
            size = "40% 70%";
            unfocus = "hide";
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
    imv = { enable = true; };
    latex = { enable = false; };
    launchers = {
      default = "fuzzel";
      fuzzel = { enable = false; };
      rofi = { enable = false; };
    };
    mpv = {
      defaultApplication = true;
      enable = true;
    };
    networking = {
      connman = { enable = false; };
      networkmanager = { enable = true; };
    };
    passwordManager = {
      _1password = { enable = false; };
      bitwarden = { enable = true; };
      default = "bitwarden";
    };
    pavucontrol = { enable = true; };
    personalEnvironment = { enable = true; };
    playerctld = { enable = false; };
    shells = {
      bash = { enable = false; };
      fish = { enable = true; };
      starship = { enable = true; };
      zsh = { enable = false; };
    };
    steam = { enable = false; };
    suiteDevelopment = { enable = false; };
    suiteEditing = { enable = false; };
    suiteGaming = { enable = false; };
    suiteMusic = { enable = false; };
    suiteOffice = { enable = false; };
    suiteRicing = { enable = false; };
    suiteSocial = { enable = false; };
    suiteVirtualization = { enable = false; };
    suiteWeb = { enable = true; };
    syncthing = { enable = true; };
    systemd = { enable = true; };
    terminals = {
      default = "kitty";
      kitty = { enable = true; };
    };
    vscode = {
      autostart = true;
      defaultApplication = true;
      enable = false;
      mkMutable = false;
    };
    xdg = { enable = true; };
  };

  home.packages = with pkgs; [
  ];

  # add device-specific home configuration here #

  home.stateVersion = "24.05";
}
