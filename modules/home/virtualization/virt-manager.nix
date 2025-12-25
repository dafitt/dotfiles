{ pkgs, ... }:
{
  home.packages = with pkgs; [
    virt-manager
  ];

  # virt-manager settings
  dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };
}
