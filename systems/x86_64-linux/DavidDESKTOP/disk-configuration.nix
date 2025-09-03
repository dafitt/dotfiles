{ lib, ... }:
with lib;
{
  imports = [
    ./disk-DavidTANK.nix
    ./disk-DavidGAMES.nix
  ];

  disko.devices = {
    disk = {
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
                  # "@" = {
                  #   mountpoint = "/";
                  # };
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

    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "size=3G"
          "mode=0755"
        ];
      };
    };
  };

  # boot.initrd.postResumeCommands = mkAfter ''
  #   mkdir --parents /tmp/impermanance
  #   mount ${config.disko.devices.disk.root.device}-part2 /tmp/impermanance
  #   if [[ -e /tmp/impermanance/@home ]]; then
  #       mkdir --parents /tmp/impermanance/@home.old.d
  #       timestamp=$(date --date="@$(stat -c %Y /tmp/impermanance/@home)" "+%Y-%m-%-d_%H:%M:%S")
  #       mv /tmp/impermanance/@home "/tmp/impermanance/@home.old.d/$timestamp"
  #   fi

  #   delete_subvolume_recursively() {
  #       IFS=$'\n'
  #       for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
  #           delete_subvolume_recursively "/tmp/impermanance/$i"
  #       done
  #       btrfs subvolume delete "$1"
  #   }

  #   for i in $(find /tmp/impermanance/@home.old.d/ -maxdepth 1 -mtime +30); do
  #       delete_subvolume_recursively "$i"
  #   done

  #   btrfs subvolume create /tmp/impermanance/@home
  #   umount /tmp/impermanance
  #   rmdir --ignore-fail-on-non-empty --parents /tmp/impermanance
  # '';

  environment.persistence."/nix/persist" = {
    hideMounts = true;

    # https://nixos.org/manual/nixos/unstable/#ch-system-state
    directories = [
      "/var/lib/nixos"
      "/var/lib/systemd"
      "/var/log/journal"

      # connections
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"

      # todo
      "/etc/ssh"
    ];
    files = [
      "/etc/machine-id"

      # users and groups
      "/etc/passwd"
      "/etc/group"
      "/etc/shadow"
      "/etc/gshadow"
      "/etc/subuid"
      "/etc/subgid"
    ];
  };
}
