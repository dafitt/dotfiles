# more options: https://search.nixos.org/options?channel=unstable

{ config, pkgs, ... }: {


  imports = [
    ./hardware-configuration.nix
    ../common-desktop.nix
  ];


  boot = {
    loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        gfxmodeEfi = "1920x1080";
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [
      # tuxedo kernel params <https://github.com/tuxedocomputers/tuxedo-keyboard/blob/v3.1.4/README.md#kernel-parameter->
      "tuxedo_keyboard.mode=0"
      "tuxedo_keyboard.brightness=25"
      "tuxedo_keyboard.color_left=0xffffff"
    ];
  };


  hardware.tuxedo-keyboard.enable = true;
  hardware.tuxedo-control-center.enable = true;


  console.keyMap = "de-latin1-nodeadkeys";


  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024; # in MiB
  }];


  networking = {
    hostName = "DavidTUX";

    firewall = {
      allowedTCPPorts = [
        22000 # syncthing
      ];
      allowedUDPPorts = [
        21027 # syncthing broadcast
        22000 # syncthing
      ];
    };
  };


  services = {
    fstrim.enable = true; # SSD
  };


  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = [ "david" ];
  #virtualisation.virtualbox.guest.enable = true;
  #virtualisation.virtualbox.guest.x11 = true;


  system.stateVersion = "23.05"; # Do not touch
}
