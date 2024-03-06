{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.virtualizaion;
in
{
  options.custom.virtualizaion = with types; {
    enable = mkBoolOpt false "Enable virtualizaion software";
  };

  config = mkIf cfg.enable {
    # Virtualisation software
    #
    home.packages = with pkgs; [
      virt-manager
      spice-gtk # Needed for USB redirection in kvm-VMs.
      bottles # run Windows software on Linux
      win-virtio # windows drivers
    ];

    dconf.settings."org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
