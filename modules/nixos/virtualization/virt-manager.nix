{ pkgs, ... }:
with pkgs;
{
  environment.systemPackages = with pkgs; [
    win-virtio
  ];

  virtualisation = {
    # kvm hypervisor
    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;
}
