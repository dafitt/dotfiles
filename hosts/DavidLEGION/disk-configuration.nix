{ lib, pkgs, ... }:
with lib;
{
  disko.devices = {
    disk = {
      "main" = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-Micron_MTFDKBA1T0TFH_2217373922F2";
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
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zlib"
                      "noatime"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [ "compress=zlib" ];
                  };
                };
              };
            };
            "swap" = {
              size = "38G";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
              };
            };
          };
        };
      };
    };

    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=3G"
          "mode=0755"
          "noexec"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    disko
  ];

  services.btrfs.autoScrub.enable = true;

  environment.persistence."/nix/persist" = {
    enable = true;
    hideMounts = true;
  };
}
