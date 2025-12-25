{ lib, pkgs, ... }:
with lib;
{
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
}
