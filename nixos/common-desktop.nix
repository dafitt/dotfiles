# more options: https://search.nixos.org/options?channel=unstable

{ config, pkgs, nix-software-center, ... }: {

  nixpkgs.config.allowUnfree = true; # Allow unfree packages

  nix.settings.experimental-features = [ "nix-command" "flakes" ]; # Experimental nix features
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };


  boot.loader.grub = {
    # TODO extraGrubInstallArgs = [];
    extraEntries = ''
      menuentry 'UEFI Firmware Settings' --id 'uefi-firmware' {
        fwsetup
      }
      menuentry "System shutdown" {
        echo "System shutting down..."
        halt
      }
      menuentry "System restart" {
        echo "System rebooting..."
        reboot
      }
    ''; # <https://wiki.archlinux.org/title/GRUB#Boot_menu_entry_examples>
    # TODO add if platform == "efi"
  };


  time.timeZone = "Europe/Berlin";

  # language & locale
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "de_DE.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_COLLATE = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };


  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  security.polkit.enable = true; # Required for Home-manager
  security.pam.services.swaylock = { }; # swaylock fix <https://github.com/NixOS/nixpkgs/issues/158025>


  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    # Monitor backlight control
    light.enable = true;

    system-config-printer.enable = true;
  };


  environment = {
    systemPackages = with pkgs; [
      bashmount # easy mounting
      gparted # graphical disk partitioning tool
      micro # easy to use texteditor
      raider # securely delete your files
      wget

      #nix-software-center.packages.${system}.nix-software-center # GUI for installing nix-packages # TODO remove
    ];
    pathsToLink = [ "/share/zsh" ];
  };


  # Basic (default) font configuration
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif" "Source Han Serif" ];
        sansSerif = [ "Noto Sans" "Source Han Sans" ];
        monospace = [ "Noto Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
    fontDir.enable = true; # /run/current-system/sw/share/X11/fonts
  };


  services = {

    gvfs = {
      enable = true; # userspace virtual filesystem (to be able to browse remote resources)
      package = pkgs.gvfs;
    };
    udisks2 = {
      enable = true; # to allow applications to query and manipulate storage devices
      settings = {
        "udisks2.conf".defaults = {
          allow = "exec";
        };
      };
    };

    connman = {
      enable = true;
      wifi.backend = "iwd";
    };

    rpcbind.enable = true; # required for NFS

    printing = {
      # <https://nixos.wiki/wiki/Printing>
      enable = true; # Enable CUPS
      drivers = [ pkgs.foomatic-db-ppds ];
    };
    #system-config-printer.enable = true; # Printing GUI
    avahi = {
      enable = true;
      nssmdns = true;
    };

    flatpak.enable = true;

    colord.enable = true; # icc profiles

    fwupd.enable = false; # update various firmware <https://nixos.wiki/wiki/Fwupd>

    openssh = {
      enable = true;
      settings = {
        # require bublic key authentication for better security
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "yes";
      };
    };
  };


  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
  };


  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland # has more features on Hyprland
      pkgs.xdg-desktop-portal-gtk # required for flatpak
    ];
  };


  systemd.user.extraConfig = ''
    DefaultEnvironment="PATH=/run/current-system/sw/bin"
  '';


  # User(s)
  users.users.david = {
    isNormalUser = true;
    description = "David Schaller";
    extraGroups = [
      "wheel" # for sudo
      "video" # for light (backlight control)
      "libvirtd" # for virt-manager
      "wireshark"
    ];
    shell = pkgs.zsh;

    openssh.authorizedKeys.keyFiles = [ ];
  };

}
