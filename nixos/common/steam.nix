{ pkgs, ... }: {

  programs.steam.enable = true;

  services.udev.extraRules = ''
    ATTR{power/control}="on"
  '';
}
