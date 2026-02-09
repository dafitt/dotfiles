{
  #meta.doc = builtins.toFile "doc.md" "Configures sudo on your system.";

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
