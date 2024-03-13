{ config, lib, pkgs, ... }: {

  # Skip the boot selection menu. [space] to open it.
  boot.loader.timeout = 0;

  fileSystems = {
    "/mnt/games" = {
      label = "GAMES"; # [How to write a label](https://wiki.archlinux.org/title/persistent_block_device_naming#by-label)
      options = [
        # [options](https://man.archlinux.org/man/mount.8#COMMAND-LINE_OPTIONS)
        "defaults"
        #"user"
        #"nofail"
        "x-gvfs-show"
        "X-mount.mkdir" # create directory if not existing
      ];
    };
    "/mnt/file" = {
      label = "FILE";
      options = [
        "defaults"
        "user"
        "nofail"
        "x-gvfs-show"
        "X-mount.mkdir" # create directory if not existing
      ];
    };
  };

  networking = {
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
}
