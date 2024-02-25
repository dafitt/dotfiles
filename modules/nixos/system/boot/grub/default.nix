{ options, config, lib, ... }:

with lib;
with lib.custom;
let
  cfg = config.system.boot.grub;
in
{
  options.system.boot.grub = with types; {
    enable = mkBoolOpt false "Whether or not to enable booting by grub.";
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
