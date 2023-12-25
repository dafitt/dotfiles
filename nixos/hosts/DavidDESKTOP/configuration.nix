{ config, lib, pkgs, ... }: {

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };


  boot.kernelParams = [
    #$ wlr-randr
    #$ head /sys/class/drm/*/status
    "video=HDMI-A-1:2560x1440@120"
    "video=DP-1:2560x1440@120"
  ];


  console.keyMap = "de-latin1-nodeadkeys";


  fileSystems = {
    "/mnt/games" = {
      label = "GAMES"; # how to write a label <https://wiki.archlinux.org/title/persistent_block_device_naming#by-label>
      options = [
        # options <https://man.archlinux.org/man/mount.8#COMMAND-LINE_OPTIONS>
        "defaults"
        #"user"
        #"nofail"
        "x-gvfs-show"
        "X-mount.mkdir" # create directory if not existing
      ];
    };
    "/mnt/file" = {
      label = "FILE"; # how to write a label <https://wiki.archlinux.org/title/persistent_block_device_naming#by-label>
      options = [
        # options <https://man.archlinux.org/man/mount.8#COMMAND-LINE_OPTIONS>
        "defaults"
        "user"
        "nofail"
        "x-gvfs-show"
        "X-mount.mkdir" # create directory if not existing
      ];
    };
    #"/home/david/.media/Archive" = {
    #  device = "192.168.18.151:/DavidTank/archive";
    #  fsType = "nfs";
    #  options = [
    #    "_netdev"
    #    "vers=4"
    #    "noauto"
    #    "x-gvfs-show"
    #    "X-mount.mkdir" # create directory if not existing
    #    "x-systemd.automount"
    #    "x-systemd.idle-timeout=300"
    #  ];
    #};
    #"/home/david/.media/Familiendaten" = {
    #  device = "192.168.18.3:/Familiendaten";
    #  fsType = "nfs";
    #  options = [
    #    "_netdev"
    #    "vers=4"
    #    "noauto"
    #    "x-gvfs-show"
    #    "X-mount.mkdir" # create directory if not existing
    #    "x-systemd.automount"
    #    "x-systemd.idle-timeout=300"
    #  ];
    #};
  };

  services.connman.enable = lib.mkForce false; # Intervenes with network configuration!

  networking = {
    hostName = "DavidDESKTOP"; # Define your hostname.

    useDHCP = false; # Is needed!
    bridges."br0".interfaces = [ "enp42s0" ];
    interfaces."br0".useDHCP = true;
    # Static host-ip
    #interfaces."br0".ipv4.addresses = [{
    #  address = "192.168.19.3";
    #  prefixLength = 23;
    #}];
    #defaultGateway = "192.168.18.1";
    #nameservers = [ "192.168.18.156" ];

    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
    };
  };


  services = {
    fstrim.enable = true; # SSD
  };


  hardware.opengl.enable = true;


  system.stateVersion = "23.05"; # Do not touch
}
