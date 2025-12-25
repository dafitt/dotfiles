{
  security = {
    sudo.enable = false;
    sudo-rs = {
      enable = true;
      extraConfig = ''
        Defaults env_keep += "EDITOR PATH DISPLAY"
      '';
    };
  };
}
