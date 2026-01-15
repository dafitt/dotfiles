{
  # sudo nix run nixpkgs#disko -- -m format,mount <file|--flake .#>
  disko.devices.disk = {
    "DavidGAMES" = {
      destroy = false;
      device = "/dev/disk/by-id/ata-Samsung_SSD_840_EVO_1TB_S1D9NSAFB17608A";
      content = {
        type = "btrfs";
        extraArgs = [
          "--force"
          "--label DavidGAMES"
        ];
        subvolumes = {
          "@" = {
            mountpoint = "/DavidGAMES";
            mountOptions = [
              "compress-force=zlib"
              # [options](https://man.archlinux.org/man/mount.8#FILESYSTEM-INDEPENDENT_MOUNT_OPTIONS)
              "users"
              "noatime"
              "defaults"
              "x-mount.mkdir"
              "x-gvfs-show"
            ];
          };
        };
      };
    };
  };
}
