# more options: https://search.nixos.org/options?channel=unstable

{ config, lib, pkgs, ... }: {

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

  # Enable sound with pipewire (over pulseaudio)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Monitor backlight control
  programs.light.enable = true;

  programs.fish = {
    enable = true;
    # also use objects provided by other packages
    vendor = {
      completions.enable = true;
      config.enable = true;
      functions.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    bashmount # easy mounting
    gparted # graphical disk partitioning tool
    micro # easy to use texteditor
    raider # securely delete your files
    wget
  ];

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
    fwupd.enable = false; # update various firmware (https://nixos.wiki/wiki/Fwupd)
  };
}
