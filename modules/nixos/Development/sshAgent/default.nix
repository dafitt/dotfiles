{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.sshAgent;
in
{
  options.dafitt.Development.sshAgent = with types; {
    enable = mkBoolOpt config.dafitt.Development.enableSuite "Whether to enable sshAgent.";
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
