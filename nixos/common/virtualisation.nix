{
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
