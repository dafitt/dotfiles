{
  programs.ssh = {
    enable = true;
  };

  services.ssh-agent.enable = true; # holds private keys
  # use with `ssh-add`
}
