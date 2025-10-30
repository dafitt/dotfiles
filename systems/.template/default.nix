# Check:
#$ nix flake check
#$ nixos-rebuild repl --fast --flake .#<host>
#nix-repl> nixosConfigurations.<host>.config

# Build:
#$ nixos-rebuild build --fast --flake .#<host>
#$ nix build .#nixosConfigurations.<host>.config.system.build.toplevel

# Activate:
#$ nixos-rebuild --flake .#<host> <test|switch|boot>
#$ nix run .#nixosConfigurations.<host>.config.system.build.toplevel

{
  pkgs,
  inputs,
  ...
}:

{
  imports = with inputs; [
    ./hardware-configuration.nix

    # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
    #nixos-hardware.nixosModules.<HARDWARE_MODULE>
  ];

  dafitt = rec {
    #NOTE These are the defaults that were taken from
    #$ nixos-rebuild --flake .#defaults repl
    #> :p config.dafitt

    appimage = {
      enable = false;
    };
    audio = {
      enable = false;
    };
    batteryOptimization = {
      enable = false;
    };
    bluetooth = {
      enable = false;
    };
    bootloader = {
      grub = {
        enable = false;
      };
      systemd-boot = {
        enable = true;
      };
    };
    displayManager = {
      gdm = {
        enable = false;
      };
      greetd = {
        enable = false;
      };
      sessionPaths = [ ];
    };
    enable = false;
    flatpak = {
      enable = false;
    };
    fonts = {
      enable = false;
      fonts = [ ];
    };
    fwupd = {
      enable = false;
    };
    gnome = {
      enable = false;
    };
    hyprland = {
      enable = false;
      hyprlock = {
        allow = false;
      };
    };
    kernel = {
      enable = false;
      package = pkgs.linuxPackages_latest;
    };
    locale = {
      enable = false;
    };
    locate = {
      enable = false;
    };
    networking = {
      connman = {
        enable = false;
      };
      firewall = {
        allowLocalsend = false;
        allowSyncthing = false;
      };
      networkmanager = {
        enable = false;
      };
    };
    printing = {
      enable = false;
    };
    shells = {
      default = null;
      fish = {
        enable = false;
      };
    };
    stylix = {
      enable = false;
    };
    suiteDevelopment = {
      enable = false;
    };
    suiteGaming = {
      enable = false;
    };
    suiteVirtualization = {
      enable = false;
    };
    systemd = {
      enable = false;
    };
    time = {
      enable = false;
    };
    users = {
      guest = {
        enable = false;
      };
    };
  };

  environment.systemPackages = with pkgs; [
  ];

  # add device-specific nixos configuration here #

  system.stateVersion = "24.04";
}
