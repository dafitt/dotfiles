{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.networkmanager;
in
{
  options.dafitt.networking.networkmanager = with types; {
    enable = mkEnableOption "networking through NetworkManager";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;

    programs.nm-applet.enable = true;

    # GTK GUI for NetworkManager
    environment.systemPackages = with pkgs; [ networkmanagerapplet ];

    environment.persistence."/nix/persist".directories = [
      "/etc/NetworkManager/system-connections"
    ];
  };
}
