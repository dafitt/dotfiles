{ config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.virt-manager;
  osCfg = osConfig.dafitt.virt-manager or null;
in
{
  options.dafitt.virt-manager = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable virt-manager.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      virt-manager
    ];

    # virt-manager settings
    dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
