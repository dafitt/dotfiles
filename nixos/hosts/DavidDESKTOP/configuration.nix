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
  };

  networking = {
    hostName = "DavidDESKTOP";

    networkmanager.enable = false;

    useDHCP = false; # Is needed!
    bridges."br0".interfaces = [ "enp42s0" ];
    interfaces."br0".useDHCP = true;
  };


  services.fstrim.enable = true; # SSD


  hardware.opengl.enable = true;


  system.stateVersion = "23.05"; # Do not touch
}
