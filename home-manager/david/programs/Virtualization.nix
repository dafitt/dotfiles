{ config, lib, pkgs, ... }: {

  # Virtualisation software
  # 
  home.packages = with pkgs; [
    virt-manager
    spice-gtk # Needed for USB redirection in kvm-VMs.
    gnome.gnome-boxes # simple virtualisation manager gui
    bottles # run Windows software on Linux
    win-virtio
  ];

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}
