{ config, lib, pkgs, ... }: {

  # activate zfs
  networking.hostId = "389a4fde"; #$ head -c 8 /etc/machine-id
  boot.supportedFilesystems = [ "zfs" ];
  # FIXME (2023-12-29) bug: kworker at 100% and gui freezes:
  #boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages; # latest compatible kernel
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
        -a /dev/disk/by-id/ata-MB4000GVYZK_ZC18DN03 -i 600 \
        -a /dev/disk/by-id/ata-MB4000GVYZK_ZC18DNEY -i 600
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
