{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Virtualization.virt-manager;
  osCfg = osConfig.dafitt.Virtualization.virt-manager or null;
in
{
  options.dafitt.Virtualization.virt-manager = with types; {
    enable = mkBoolOpt (osCfg.enable or config.dafitt.Virtualization.enableSuite) "Whether to enable virt-manager.";
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
