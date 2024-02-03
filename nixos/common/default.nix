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

  # Monitor backlight control
  programs.light.enable = true;

  # To update various firmware (https://nixos.wiki/wiki/Fwupd)
  services.fwupd.enable = false; # enable, when needed

  environment.systemPackages = with pkgs; [
    raider # securely delete files
    wget
  ];
}