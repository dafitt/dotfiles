{ lib, osConfig ? { }, ... }: {

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = lib.mkDefault (osConfig.system.stateVersion or "23.11");
}
