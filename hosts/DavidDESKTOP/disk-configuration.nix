{ lib, pkgs, ... }:
with lib;
{
  imports = [
    ./disk-DavidGAMES.nix
  ];

  disko.devices = {
    disk = {
      "main" = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_BLACK_SN7100_1TB_2451BP403282";
        content = {
          type = "gpt";
          partitions = {
            "ESP" = {
              priority = 1;
              name = "ESP";
              start = "1M"; # iB
              end = "2G"; # iB
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
                  # "@" = {
                  #   mountpoint = "/";
                  #   mountOptions = [
                  #     "compress=none"
                  #     "noatime"
                  #   ];
                  # };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [ "compress=zlib" ];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zlib"
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
            "swap" = {
              size = "72G";
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

  ## https://www.notashelf.dev/posts/impermanence/#impermanence
  #boot.initrd.systemd = {
  #  enable = true;
  #  services.rollback = {
  #    description = "Rollback BTRFS root drive to a pristine state";
  #    wantedBy = [ "initrd.target" ];

  #    # LUKS/TPM process. If you have named your device mapper something other
  #    # than 'enc', then @enc will have a different name. Adjust accordingly.
  #    # after = [ "me @ domain" ];

  #    before = [ "sysroot.mount" ];

  #    unitConfig.DefaultDependencies = "no";
  #    serviceConfig.Type = "oneshot";
  #    script = ''
  #      echo "Mounting root BTRFS drive..."
  #      mkdir --parents /mnt
  #      mount --options "subvol=/" ${config.disko.devices.disk.root.device}-part2 /mnt

  #      if [[ -e /mnt/@home ]]; then
  #          mkdir --parents /mnt/home.old.d
  #          timestamp=$(date --date="@$(stat --format=%Y /mnt/@home)" "+%Y-%m-%dT%H:%M:%S")
  #          echo "Moving @home to 'home.old.d/$timestamp'..."
  #          mv /mnt/@home "/mnt/home.old.d/$timestamp"
  #      fi

  #      delete_subvolume_recursively() {
  #          IFS=$'\n'
  #          for subvolume in $(btrfs subvolume list -o "$1" | cut --fields 9- --delimiter ' '); do
  #              delete_subvolume_recursively "/mnt/$subvolume"
  #          done
  #          echo "Deleting subvolume '$subvolume'..."
  #          btrfs subvolume delete "$1"
  #      }
  #      echo "Deleting very old subvolumes..."
  #      for subvolume in $(find /mnt/home.old.d/ -maxdepth 1 -mtime +30); do
  #          delete_subvolume_recursively "$subvolume"
  #      done

  #      echo "Creating new empty subvolume @home..."
  #      btrfs subvolume create /mnt/@home

  #      echo "Finished successfully. Unmounting..."
  #      umount /mnt
  #    '';
  #  };
  #};

  environment.persistence."/persist" = {
    enable = true;
    hideMounts = true;
  };

  systemd.tmpfiles.rules = [
    "d /home/snapshots.d 0755 btrbk btrbk"
    "d /persist/snapshots.d 0755 btrbk btrbk"
  ];

  # https://digint.ch/btrbk/doc/readme.html
  services.btrbk = {
    instances."home" = {
      onCalendar = "hourly";
      settings = {
        subvolume = "/home";
        snapshot_dir = "/home/snapshots.d";
        snapshot_preserve = "16h 7d 3w 2m";
        snapshot_preserve_min = "12h";
      };
    };
    instances."persist" = {
      onCalendar = "hourly";
      settings = {
        subvolume = "/persist";
        snapshot_dir = "/persist/snapshots.d";
        snapshot_preserve = "16h 7d 3w 2m";
        snapshot_preserve_min = "12h";
      };
    };
  };
}
