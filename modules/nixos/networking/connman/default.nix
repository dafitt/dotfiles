{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.networking.connman;
in
{
  options.dafitt.networking.connman = with types; {
    enable = mkBoolOpt (config.dafitt.networking.enable == "connman") "Whether to enable networking through connman.";
  };

  config = mkIf cfg.enable {
    services.connman = {
      enable = true;
      wifi.backend = "iwd";
      extraConfig = ''
        [General]
        PreferredTechnologies=ethernet,wifi
      '';

      networkInterfaceBlacklist = [ "vmnet" "vboxnet" "virbr" "ifb" "ve" ];
    };

    # GTK GUI for Connman
    environment.systemPackages = with pkgs; [
      connman-gtk
      connman-ncurses
      connman-notify
    ];
  };
}
