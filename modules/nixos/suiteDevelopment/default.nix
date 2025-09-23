{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteDevelopment;
in
{
  options.dafitt.suiteDevelopment = with types; {
    enable = mkEnableOption "the Development suite";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      bashmount # easy mounting
      gparted # graphical disk partitioning tool
      gptfdisk # gdisk, cgdisk, sgdisk
      hdparm # get/set ATA/SATA drive parameters
    ];

    programs.direnv = {
      enable = true;
      silent = true;
    };

    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Add any missing dynamic libraries for unpackaged
        # programs here, NOT in environment.systemPackages
      ];
    };

    # Enable ssh-agent auth support for passwordless sudo.
    services.gnome.gcr-ssh-agent.enable = mkForce false;
    programs.ssh.startAgent = true;
    security.pam = {
      sshAgentAuth.enable = true;
      services."sudo".sshAgentAuth = true;
    };
  };
}
