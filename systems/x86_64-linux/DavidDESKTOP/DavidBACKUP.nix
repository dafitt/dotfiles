{ config, lib, pkgs, ... }: {

  # automount on plugin
  # https://unix.stackexchange.com/questions/716214/unmount-mount-drive-when-its-disconnected-connected-automatically/716597#716597
  services.udev.extraRules = ''KERNEL=="sd[a-z][0-9]", SUBSYSTEM=="block", ENV{ID_FS_LABEL}=="DavidBACKUP", ACTION=="add", RUN+="${pkgs.systemd}/bin/systemctl restart mnt-DavidBACKUP.mount"'';
  systemd.mounts = [{
    unitConfig = {
      Description = "disk with label DavidBACKUP";
      Wants = [ "mnt-DavidBACKUP.service" ];
      StopWhenUnneeded = true;
    };
    what = "/dev/disk/by-label/DavidBACKUP"; #TEST LABEL=DavidBACKUP
    where = "/mnt/DavidBACKUP";
  }];
  systemd.services."mnt-DavidBACKUP" = {
    unitConfig = {
      Description = "change owner of DavidBACKUP";
      RequiresMountsFor = [ "/mnt/DavidBACKUP" ];
      Wants = [ "borgbackup-job-DavidBACKUP.service" ]; # autostart
    };
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''${pkgs.bash}/bin/bash -c "chown david:users /mnt/DavidBACKUP"'';
    };
  };

  services.borgbackup.jobs."DavidBACKUP" = rec {
    repo = "/mnt/DavidBACKUP/DavidBACKUP-repo";
    encryption.mode = "repokey-blake2";
    encryption.passCommand = "cat /home/david/.local/secrets/DavidBACKUP.key";
    compression = "auto,zstd";
    user = "david";
    group = "users";

    paths = [
      "/DavidTANK/Archive"
      "/home/david/Sync"
      "/home/david/Desktop"
      "/home/david/Documents"
      "/home/david/Pictures"
      "/home/david/Videos"
      "/home/david/Templates"
    ];
    prune.keep = {
      within = "1m";
      monthly = 24;
      yearly = 3;
    };

    preHook = ''
      mkdir -p ${repo}
    '';
  };
  systemd.services."borgbackup-job-DavidBACKUP" = {
    unitConfig = {
      RequiresMountsFor = [ "/DavidTANK" "/mnt/DavidBACKUP" ]; # autofail
    };
    serviceConfig = {
      ReadWritePaths = [ "/mnt/DavidBACKUP" ];
    };
  };
}
