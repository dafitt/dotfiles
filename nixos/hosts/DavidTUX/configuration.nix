{ config, pkgs, tuxedo-nixos, ... }: {

  imports = [ tuxedo-nixos.nixosModules.default ];


  boot.loader = {
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

  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness


  # TUXEDO Control Center
  hardware.tuxedo-control-center = {
    enable = true;
    package = tuxedo-nixos.packages.x86_64-linux.default; # FIX for [Build broken on nixos-unstable](https://github.com/blitz/tuxedo-nixos/issues/5)
  };
  hardware.tuxedo-keyboard.enable = true;
  boot.kernelParams = [
    # tuxedo kernel params <https://github.com/tuxedocomputers/tuxedo-keyboard/blob/v3.1.4/README.md#kernel-parameter->
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=25"
    "tuxedo_keyboard.color_left=0xffffff"
  ];


  console.keyMap = "de-latin1-nodeadkeys";


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


  hardware.opengl.enable = true;


  system.stateVersion = "23.05"; # Do not touch
}
