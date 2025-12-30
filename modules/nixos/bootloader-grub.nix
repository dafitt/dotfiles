{ lib, ... }:
with lib;
{
  boot.loader.grub = {
    enable = true;
    configurationLimit = mkDefault 50;

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

  # Depending on host:
  # boot.loader.grub = {
  #   device = "nodev";
  #   efiSupport = true;
  #   useOSProber = true;
  # };
}
