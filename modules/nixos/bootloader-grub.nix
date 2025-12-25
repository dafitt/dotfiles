{
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    configurationLimit = 7;
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
}
