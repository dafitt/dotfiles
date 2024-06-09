{ config, lib, pkgs, ... }: {

  dafitt.kernel.package = config.boot.zfs.package.latestCompatibleLinuxPackages;
  # [Enable zfs](https://openzfs.github.io/openzfs-docs/Getting%20Started/NixOS/index.html#installation)
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "389a4fde"; #$ head -c 8 /etc/machine-id

  # Configure zfs
  boot.zfs = {
    extraPools = [ "DavidTANK" ];
  };
  services.zfs = {
    autoScrub.enable = true; # recommended
  };

  # spin down hard drives
  systemd.services."hd-idle" = {
    description = "external HD spin down daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''${pkgs.hd-idle}/bin/hd-idle -i 0 \
        -a /dev/disk/by-id/ata-MB4000GVYZK_ZC18DN03 -i 600 \
        -a /dev/disk/by-id/ata-MB4000GVYZK_ZC18DNEY -i 600
        '';
    };
  };

  # NFS
  services = {
    #nfs.server.enable = true; # for zfs set sharenfs=...
    #rpcbind.enable = true; # required for NFS
  };
}
