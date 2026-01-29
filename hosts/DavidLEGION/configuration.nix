{
  lib,
  pkgs,
  inputs,
  ...
}:

# Lenovo Legion7 16 ARHA7 Laptop
# CPU: AMD Ryzen 7 6800 H with Radeon Graphics (3,20GHz - 4,70GHz)
# RAM: 32GB (2x16GB) SO-DIMM DDR5 4800MHz
# GPU: AMD Radeon RX 6850M 10GB GDDR6
# Display: 16" WQXGA (2560x1600px), IPS, Blendschutz, Dolby Vision, Free-Sync, HDR 400, 500 Nits, 165Hz
# Camera: 1080p-FHD Frontcamera
# Battery: 4 cell 99.9Wh
# WIFI: 6E 11AX (2x2)
# Bluetooth: 5.1
# Color: Storm Grey
with lib;
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "23.05";

  imports =
    with inputs;
    with inputs.self.nixosModules;
    [
      ./hardware-configuration.nix

      disko.nixosModules.disko
      ./disk-configuration.nix
      impermanance

      # [HARDWARE_MODULES](https://github.com/NixOS/nixos-hardware/blob/master/flake.nix)
      nixos-hardware.nixosModules.lenovo-legion-16arha7

      SHARED
      batteryOptimization
      bluetooth
      bootloader-limine
      desktopEnvironment-gnome
      development
      gaming
      loginManager-gdm
      networking-networkmanager
      printing
      virtualization
    ];

  services.logind.settings.Login = {
    # logind.conf(5)
    HandlePowerKey = "sleep";
    HandlePowerKeyLongPress = "poweroff";
  };

  services.fprintd.enable = mkForce false; # No fingerprint reader

  services.lact.enable = true;
  hardware.amdgpu.overdrive.enable = true;
  environment.persistence."/persist".files = [ "/etc/lact/config.yaml" ];

  #TODO services.thinkfan = {
  #  enable = true;
  #};
  ## man tinkfan 1/5

  services.tlp.settings = {
    # [docs](https://linrunner.de/tlp/)

    # battery care
    #$ sudo tlp-stat -b
    STOP_CHARGE_THRESH_BAT0 = 1;

    # graphics
    #$ sudo tlp-stat -g
    RADEON_DPM_STATE_ON_AC = "performance";
    RADEON_DPM_STATE_ON_BAT = "battery";

    # kernel
    NMI_WATCHDOG = 0;

    # profile
    PLATFORM_PROFILE_ON_AC = "balanced";
    PLATFORM_PROFILE_ON_BAT = "low-power";

    # processor
    #$ sudo tlp-stat -p
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = mkForce "schedutil";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_SCALING_MIN_FREQ_ON_AC = 0;
    CPU_SCALING_MAX_FREQ_ON_AC = 3200000;
    CPU_SCALING_MIN_FREQ_ON_BAT = 0;
    CPU_SCALING_MAX_FREQ_ON_BAT = 1800000;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_MAX_PERF_ON_BAT = 80;
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
  };

  services.udev.extraRules = mkMerge [
    # [diable wakeup](https://wiki.nixos.org/wiki/Power_Management#System_Immediately_wakes_up_from_suspend)
    #$ cat /proc/acpi/wakeup
    ''ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"''
    # diable wakeup: XHC0 (Keyboard)
    ''ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x161d" ATTR{power/wakeup}="disabled"''
    # diable wakeup: XHC1 (external Mouse)
    ''ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x161e" ATTR{power/wakeup}="disabled"''

    # autosuspend USB devices
    ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
    # autosuspend PCI devices
    ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''

    # disable Ethernet Wake-on-LAN
    ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 1;
    systemd-boot.configurationLimit = 5;
  };

  boot.kernel.sysctl."vm.swappiness" = 10; # reduce swappiness
}
