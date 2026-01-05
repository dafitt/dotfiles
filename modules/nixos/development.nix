{ lib, ... }:
with lib;
{
  documentation.enable = true;
  documentation.dev.enable = true;

  programs.direnv = {
    enable = true;
    silent = true;
  };

  programs.nix-ld.enable = true;

  # Enable ssh-agent auth support for passwordless sudo.
  services.gnome.gcr-ssh-agent.enable = mkForce false;
  programs.ssh.startAgent = true;
  security.pam = {
    sshAgentAuth.enable = true;
    services."sudo".sshAgentAuth = true;
  };
}
