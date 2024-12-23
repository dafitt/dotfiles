{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.suiteVirtualization;
in
{
  options.dafitt.suiteVirtualization = with types; {
    enable = mkEnableOption "the Virtualization suite";
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
