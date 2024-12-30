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
    dafitt = mkDefault {
      appimage.enable = true;
      audio.enable = true;
      bootloader.systemd-boot.enable = true;
      fonts.enable = true;
      gnome.enable = true;
      kernel.enable = true;
      locale.enable = true;
      locate.enable = true;
      networking.firewall.allowSyncthing = true;
      networking.networkmanager.enable = true;
      shells.default = "fish";
      stylix.enable = true;
      systemd.enable = true;
      time.enable = true;
      users.guest.enable = true;
    };
  };
}
