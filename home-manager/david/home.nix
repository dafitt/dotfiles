# home-manager standalone

{ config, lib, pkgs, ... }: {

  nixpkgs = {
    #overlays = [ ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true; # Workaround for [Flake cannot use unfree packages](https://github.com/nix-community/home-manager/issues/2942)
    };
  };

  home = {
    username = "david";
    homeDirectory = "/home/david";

    sessionVariables = rec {
      # Default programs
      BROWSER = "${config.programs.librewolf.package}/bin/librewolf";
      EDITOR = "${pkgs.micro}/bin/micro";
      GDITOR = "${pkgs.vscode}/bin/code";
      TERMINAL = "${config.programs.kitty.package}/bin/kitty";
      TOP = "${config.programs.btop.package}/bin/btop"; # preferred system monitor
    };

    language.base = "en_US.UTF-8";
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # For other OSes than NixOS
  #targets.genericLinux.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05"; # [When do I update stateVersion?](https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion)
}

# more options: <https://mipmip.github.io/home-manager-option-search/?query=hyprland>
# more options: <https://nix-community.github.io/home-manager/options.html>
