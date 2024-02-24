{ config, lib, pkgs, ... }: {

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
}
