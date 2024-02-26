{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.features.sshAgent;
in
{
  options.custom.features.sshAgent = with types; {
    enable = mkBoolOpt false "Enable sshAgent";
  };

  config = mkIf cfg.enable {
    # Enable ssh-agent auth support for passwordless sudo.
    programs.ssh.startAgent = true;
    security.pam = {
      enableSSHAgentAuth = true;
      services.sudo.sshAgentAuth = true;
    };

    # TODO 24.05
    #programs.ssh.startAgent = true;
    #security.pam = {
    #  sshAgentAuth.enable = true;
    #  services."sudo".sshAgentAuth = true;
    #};
    #services.openssh.enable = true;
  };
}
