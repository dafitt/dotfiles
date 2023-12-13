{ config, lib, pkgs, ... }: {

  # activate zfs
  networking.hostId = "389a4fde"; #$ head -c 8 /etc/machine-id
  boot.supportedFilesystems = [ "zfs" ];
  boot.kernelPackages = lib.mkForce config.boot.zfs.package.latestCompatibleLinuxPackages; # latest compatible kernel
  boot.zfs = {
    forceImportRoot = false;
    extraPools = [ "DavidTANK" ];
  };

  # spin down hard drives
  systemd.services."hd-idle" = {
    description = "External HD spin down daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = ''${pkgs.hd-idle}/bin/hd-idle -i 0 \
        -a /dev/disk/by-id/ata-MB4000GVYZK_ZC18DN03 -i 300 \
        -a /dev/disk/by-id/ata-MB4000GVYZK_ZC18DNEY -i 300
        '';
    };
  };

  services.zfs = {
    autoScrub.enable = true; # recommended
  };

  # NFS
  services = {
    #nfs.server.enable = true; # for zfs set sharenfs=...
    #rpcbind.enable = true; # required for NFS
  };
}