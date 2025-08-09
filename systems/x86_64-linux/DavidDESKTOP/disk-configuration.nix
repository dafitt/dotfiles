{
  imports = [ ./disk-DavidTANK.nix ];

  disko.devices.disk = {
    "root" = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-Samsung_SSD_980_PRO_2TB_S69ENF0W741037J";
      content = {
        type = "gpt";
        partitions = {
          "ESP" = {
            priority = 1;
            name = "ESP";
            start = "1M"; # iB
            end = "1G"; # iB
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
            };
          };
          "main" = {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [
                "--force"
                "--label root"
              ];
              subvolumes = {
                "root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" ];
                };
                "nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd" "noatime" ];
                };
                "home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" ];
                };
              };
            };
          };
        };
      };
    };
    #"DavidGAMES" = {
    #  type = "disk";
    #  device = "/dev/disk/by-id/ata-Samsung_SSD_840_EVO_1TB_S1D9NSAFB17608A";
    #  content = {
    #    type = "btrfs";
    #    extraArgs = [
    #      "--force"
    #      "--label DavidGAMES"
    #    ];
    #    subvolumes = {
    #      "DavidGAMES" = {
    #        mountpoint = "/mnt/DavidGAMES";
    #        mountOptions = [
    #          "compress=zstd"
    #          # [options](https://man.archlinux.org/man/mount.8#FILESYSTEM-INDEPENDENT_MOUNT_OPTIONS)
    #          "defaults"
    #          "x-gvfs-show"
    #        ];
    #      };
    #    };
    #  };
    #};
  };
}
