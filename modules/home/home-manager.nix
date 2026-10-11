{
  #meta.doc = builtins.toFile "doc.md" "Home Manager self-management and optimizations.";

  programs.home-manager.enable = true;

  home = {
    backupFileExtension = "hm-old"; # move existing files rather than failing
    overwriteBackup = true;
  };

  systemd.user.startServices = "sd-switch"; # Nicely reload system units when changing configs
}
