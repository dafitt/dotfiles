{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.virt-manager;
in
{
  options.dafitt.virt-manager = with types; {
    enable = mkEnableOption "virt-manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      win-virtio # windows drivers
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
  };
}
