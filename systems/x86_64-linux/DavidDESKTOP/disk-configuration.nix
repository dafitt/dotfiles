{
  imports = [
    ./disk-DavidTANK.nix
    ./disk-DavidGAMES.nix
  ];

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
                "@" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd" ];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [
                    "compress=zstd"
                    "noatime"
                  ];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
