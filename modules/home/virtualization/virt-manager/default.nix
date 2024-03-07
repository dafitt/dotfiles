{ config, lib, options, osConfig ? { }, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.virtualizaion.virt-manager;
  osCfg = osConfig.custom.virtualizaion.virt-manager or null;
in
{
  options.custom.virtualizaion.virt-manager = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Enable virt-manager";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      virt-manager
      spice-gtk # Needed for USB redirection in kvm-VMs.
      win-virtio # windows drivers
    ];

    dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
