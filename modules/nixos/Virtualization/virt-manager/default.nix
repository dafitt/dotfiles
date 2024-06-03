{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Virtualization.virt-manager;
in
{
  options.dafitt.Virtualization.virt-manager = with types; {
    enable = mkBoolOpt config.dafitt.Virtualization.enableSuite "Enable virt-manager, a graphical tool for managing virtual machines.";
  };

  config = mkIf cfg.enable {
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
  };
}
