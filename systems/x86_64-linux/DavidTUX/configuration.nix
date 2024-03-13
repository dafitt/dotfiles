{ config, pkgs, inputs, ... }: {

  imports = [ inputs.tuxedo-nixos.nixosModules.default ];

  boot.loader.timeout = 5;

  # TUXEDO Control Center
  hardware.tuxedo-control-center = {
    enable = true;
    package = inputs.tuxedo-nixos.packages.x86_64-linux.default; # FIX for [Build broken on nixos-unstable](https://github.com/blitz/tuxedo-nixos/issues/5)
  };
  hardware.tuxedo-keyboard.enable = true;
  boot.kernelParams = [
    # [tuxedo kernel params](https://github.com/tuxedocomputers/tuxedo-keyboard/blob/v3.1.4/README.md#kernel-parameter-)
    "tuxedo_keyboard.mode=0"
    "tuxedo_keyboard.brightness=25"
    "tuxedo_keyboard.color_left=0xffffff"
  ];

  networking.firewall = {
    allowedTCPPorts = [
      22000 # Syncthing traffic
    ];
    allowedUDPPorts = [
      22000 # Syncthing traffic
      21027 # Syncthing discovery
    ];
  };
}
