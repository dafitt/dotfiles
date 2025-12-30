{
  # sudo nix run nixpkgs#disko -- -m format,mount <file|--flake .#>
  disko.devices.disk = {
    "DavidTANK" = {
      destroy = false;
      device = "/dev/disk/by-id/ata-ST4000VN008-2DR166_ZDH5AE7Q";
      content = {
        type = "btrfs";
        extraArgs = [
          "--force"
          "--label DavidTANK"
          "--data raid10"
          "--metadata raid10"
          "/dev/disk/by-id/ata-ST4000VN008-2DR166_ZGY3DC1B"
          "/dev/disk/by-id/ata-MB4000GVYZK_ZC18DNEY"
          "/dev/disk/by-id/ata-MB4000GVYZK_ZC18DN03"
        ];
        subvolumes = {
          "@DavidARCHIVE" = {
            mountpoint = "/DavidARCHIVE";
            mountOptions = [
              "compress-force=zstd"
              "autodefrag"
              # [options](https://man.archlinux.org/man/mount.8#FILESYSTEM-INDEPENDENT_MOUNT_OPTIONS)
              "defaults"
              "x-gvfs-show"
            ];
          };
        };
      };
    };
  };

  services.smartd = {
    enable = true;
    devices = [
      { device = "/dev/disk/by-id/ata-ST4000VN008-2DR166_ZDH5AE7Q"; }
      { device = "/dev/disk/by-id/ata-ST4000VN008-2DR166_ZDH5AE7Q"; }
      { device = "/dev/disk/by-id/ata-MB4000GVYZK_ZC18DNEY"; }
      { device = "/dev/disk/by-id/ata-MB4000GVYZK_ZC18DN03"; }
    ];
  };
}
