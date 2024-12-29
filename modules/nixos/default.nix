{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt;
in
{
  options.dafitt = with types; {
    enable = mkEnableOption "dafitt defaults";
  };

  config = mkIf cfg.enable {
    dafitt = {
      appimage.enable = true;
      audio.enable = true;
      fonts.enable = true;
      gnome.enable = true;
      kernel.enable = true;
      locate.enable = true;
      systemd.enable = true;
      time.enable = true;
      users.guest.enable = true;
      locale.enable = true;
      shells.default = "fish";
    };
  };
}
