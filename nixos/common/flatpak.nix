{ pkgs, ... }: {
  services.flatpak.enable = true;

  xdg.portal = {
    enable = true;
    config.common.default = [ "*" ]; # fix weblinks not opening in default browser}
  };
}
