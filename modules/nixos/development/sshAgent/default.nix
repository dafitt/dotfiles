{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.sshAgent;
in
{
  options.dafitt.development.sshAgent = with types; {
    enable = mkBoolOpt config.dafitt.development.enableSuite "Enable sshAgent.";
  };

  config = mkIf cfg.enable {
    # Enable ssh-agent auth support for passwordless sudo.
    programs.ssh.startAgent = true;
    security.pam = {
      sshAgentAuth.enable = true;
      services."sudo".sshAgentAuth = true;
    };
    #services.openssh.enable = true;
  };
}
