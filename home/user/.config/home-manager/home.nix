# home-manager standalone INSTALLATION
# Only short summary: for more see <https://nix-community.github.io/home-manager/index.html#ch-installation>
# -----
# 1. Add unstable channel $ sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
# 2. $ sudo nix-channel --update
# 3. Install $ nix-shell '<home-manager>' -A install

{ config, lib, pkgs, ... }: {

  imports = [
    ./modules/file.mutable.nix
    ./programs
  ];

  home = {
    username = "david";
    homeDirectory = "/home/david";

    sessionVariables = {
      # Default programs
      BROWSER = "${config.programs.librewolf.package}/bin/librewolf";
      EDITOR = "${pkgs.micro}/bin/micro";
      TERMINAL = "${config.programs.kitty.package}/bin/kitty";
      TERM = "${config.programs.kitty.package}/bin/kitty";
      TOP = "${config.programs.btop.package}/bin/btop"; # preferred system monitor
    };

    language.base = "en_US.UTF-8";

    packages = with pkgs; [
      # Fonts
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
      fira-code-symbols # the ligatures aviable as symbols
      #font-awesome
      cantarell-fonts
      liberation_ttf
      inter
    ];
  };

  # discover fonts and configurations installed through home.packages and nix-env
  fonts.fontconfig.enable = true;

  #systemd.user = {
  #  automounts = { };
  #  mounts = {
  #    "home-${config.home.username}-.media-Archive" = {
  #      Unit.Description = "Mount DavidTanks archive";
  #      Unit.After = [ "nss-lookup.target" ];
  #      Install.WantedBy = [ "multi-user.target" ];
  #      Mount = {
  #        What = "192.168.18.151:/DavidTank/archive";
  #        Where = "/home/${config.home.username}/.media/Archive";
  #        Type = "nfs";
  #        Options = "noatime,noauto,_netdev,user,setuid=1000,vers=4";
  #        TimeoutSec = "30";
  #      };
  #    };
  #  };
  #};

  gtk = {
    theme = {
      name = lib.mkForce "adw-gtk3-dark"; # dark theme
      #package = lib.mkForce pkgs.orchis-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "black";
      };
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
      gtk-primary-button-warps-slider = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
    style.package = pkgs.adwaita-qt;
    style.name = lib.mkForce "adwaita-dark";
  };

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    mimeApps = {
      #enable = true;
      #defaultApplications = {
      #  #$ xdg-mime query filetype <https://wiki.archlinux.org/title/Xdg-utils#xdg-mime>
      #  #$ find / -name "*zathura*.desktop" 2>/dev/null | fzf
      #  "application/pdf" = "org.gnome.Evince.desktop";
      #  "application/sql" = "micro.desktop";
      #  "application/x-shellscript" = "micro.desktop";
      #  "audio/mp2" = "mpv.desktop";
      #  "audio/mp4" = "mpv.desktop";
      #  "audio/mpeg" = "mpv.desktop";
      #  "audio/ogg" = "mpv.desktop";
      #  "inode/directory" = "pcmanfm.desktop";
      #  "image/avif" = "imv-dir.desktop";
      #  "image/bmp" = "imv-dir.desktop";
      #  "image/gif" = "imv-dir.desktop";
      #  "image/heic" = "imv-dir.desktop";
      #  "image/heif" = "imv-dir.desktop";
      #  "image/jp2" = "imv-dir.desktop";
      #  "image/jpeg" = "imv-dir.desktop";
      #  "image/jpg" = "imv-dir.desktop";
      #  "image/jxl" = "imv-dir.desktop";
      #  "image/png" = "imv-dir.desktop";
      #  "image/svg+xml" = "org.gnome.eog.desktop";
      #  "image/tiff" = "imv-dir.desktop";
      #  "image/webp" = "imv-dir.desktop";
      #  "image/x-bmp" = "imv-dir.desktop";
      #  "image/x-portable-anymap" = "imv-dir.desktop";
      #  "image/x-portable-bitmap" = "imv-dir.desktop";
      #  "image/x-portable-graymap" = "imv-dir.desktop";
      #  "image/x-tga" = "imv-dir.desktop";
      #  "image/x-xpixmap" = "imv-dir.desktop";
      #  "text/csv" = "micro.desktop";
      #  "text/html" = "micro.desktop";
      #  "text/plain" = "org.gnome.gedit.desktop";
      #  "text/x-scss" = "micro.desktop";
      #  "video/mp4" = "mpv.desktop";
      #  "video/mpeg" = "mpv.desktop";
      #  "video/ogg" = "mpv.desktop";
      #  "video/quicktime" = "mpv.desktop";
      #  "video/vivo" = "mpv.desktop";
      #  "video/webm" = "mpv.desktop";
      #};
    };
    userDirs = {
      enable = true;
      createDirectories = true;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
        XDG_SECRETS_DIR = "${config.home.homeDirectory}/.secrets";
      };
    };
  };

  services = {

    redshift = {
      enable = true;
      latitude = "48.000";
      longitude = "12.650";
      temperature.night = 3800;
      temperature.day = 6500;
    };

    udiskie = {
      # mount daemon
      enable = true;
      notify = false;
      settings = {
        icon_names.media = [ "media-optical" ];
      };
    };

    mako = {
      # notification daemon
      # options $ man 5 mako
      enable = true;
      anchor = "bottom-right";
      borderRadius = config.wayland.windowManager.hyprland.settings.decoration.rounding;
      borderSize = config.wayland.windowManager.hyprland.settings.general.border_size;
      defaultTimeout = 30;
      format = "%a\\n%s\\n%b";
      sort = "+time";
    };

    swayosd.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile."nixpkgs/config.nix".text = "{ allowUnfree = true; }";

  # For other OSes than NixOS
  #targets.genericLinux.enable = true;

  home.stateVersion = "23.05"; # Do not touch
}
# more options: <https://mipmip.github.io/home-manager-option-search/?query=hyprland>
# more options: <https://nix-community.github.io/home-manager/options.html>
