# more options: https://search.nixos.org/options?channel=unstable
{ config, pkgs, ... }: {


  imports = [
    ../hardware-configuration.nix
    ../shared-desktop.nix
  ];


  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      gfxmodeEfi = "2560x1440";
    };
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };


  # activate zfs
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages; # latest compatible kernel


  boot.kernelParams = [
    #$ xrandr --query
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

  networking = {
    hostName = "DavidDESKTOP"; # Define your hostname.
    hostId = "389a4fde"; #$ head -c 8 /etc/machine-id

    #proxy.default = "http://user:password@proxy:port/";
    #proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    firewall = {
      #allowedTCPPorts = [ ... ];
      #allowedUDPPorts = [ ... ];
    };
  };


  services = {
    fstrim.enable = true; # SSD

    zfs = {
      autoScrub.enable = true; # recommended
    };

    nfs.server.enable = true; # for zfs set sharenfs=...
  };


  system.stateVersion = "23.05"; # Do not touch
}
