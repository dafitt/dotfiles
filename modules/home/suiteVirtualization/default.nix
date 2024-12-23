{ options, config, lib, pkgs, osConfig ? { }, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteVirtualization;
  osCfg = osConfig.dafitt.suiteVirtualization or null;
in
{
  options.dafitt.suiteVirtualization = with types; {
    enable = mkBoolOpt (osCfg.enable or false) "Whether to enable the Virtualization suite.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      bottles # run Windows software on Linux
      spice-gtk # Needed for USB redirection in kvm-VMs.
      virt-manager
      win-virtio # windows drivers
    ];

    # virt-manager settings
    dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
