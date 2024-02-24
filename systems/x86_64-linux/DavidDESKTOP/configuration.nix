{ config, lib, pkgs, ... }: {

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };

  # Keyboard layout
  console.keyMap = "de-latin1-nodeadkeys";
  services.xserver = { layout = "de"; xkbVariant = "nodeadkeys"; };


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

    firewall = {
      allowedTCPPorts = [
        22000 # Syncthing traffic
      ];
      allowedUDPPorts = [
        22000 # Syncthing traffic
        21027 # Syncthing discovery
      ];
    };
  };


  services.fstrim.enable = true; # SSD


  hardware.opengl.enable = true;
}
