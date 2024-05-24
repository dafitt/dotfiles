{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.virtualization.virt-manager;
in
{
  options.dafitt.virtualization.virt-manager = with types; {
    enable = mkBoolOpt false "Enable virt-manager, a graphical tool for managing virtual machines.";
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
