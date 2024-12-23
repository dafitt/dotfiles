{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.bootloader.grub;
in
{
  options.dafitt.bootloader.grub = with types; {
    enable = mkBoolOpt (config.dafitt.bootloader.enable == "grub") "Whether to enable booting by grub.";
  };

  config = mkIf cfg.enable {
    boot.loader.grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      configurationLimit = 5;
      useOSProber = true;
      extraEntries = ''
        if [ "$grub_platform" = "efi" ]; then
            menuentry 'UEFI Firmware Settings' $menuentry_id_option 'uefi-firmware' {
                fwsetup
            }
        fi
        menuentry "System shutdown" {
          echo "System shutting down..."
          halt
        }
        menuentry "System restart" {
          echo "System rebooting..."
          reboot
        }
      '';
    };
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
