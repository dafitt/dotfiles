{
  config,
  lib,
  pkgs,
  ...
}:
{

  services = {
    # Better scheduling for CPU cycles
    system76-scheduler.settings.cfsProfiles.enable = true;

    # Cooling management, prevents overheating
    thermald.enable = true;

    # Enable TLP power management
    power-profiles-daemon.enable = false; # Disable GNOMEs power management
    tlp = {
      # power management daemon
      # [docs](https://linrunner.de/tlp/)
      #$ tlp-stst --help
      enable = true;
      settings = {
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
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
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
    };

    logind = {
      powerKey = "suspend";
      powerKeyLongPress = "poweroff";
    };

    upower = {
      enable = true; # provides power management support to applications
      criticalPowerAction = "Hibernate";
    };

    #TODO thinkfan = {
    #  enable = true;
    #};
    ## man tinkfan 1/5

    udev.enable = true;
    udev.extraRules = lib.mkMerge [
      # [diable wakeup](https://wiki.nixos.org/wiki/Power_Management#System_Immediately_wakes_up_from_suspend)
      #$ cat /proc/acpi/wakeup
      ''ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"''
      # diable wakeup: USB XHC0 (Keyboard)
      ''ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x161d" ATTR{power/wakeup}="disabled"''
      # diable wakeup: USB XHC1 (external Mouse)
      ''ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x161e" ATTR{power/wakeup}="disabled"''

      # autosuspend USB devices
      ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
      # autosuspend PCI devices
      ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
      # disable Ethernet Wake-on-LAN
      ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
    ];
  };

  # stock NixOS power management: hibernate & suspend
  powerManagement.enable = true;

  # Enable powertop
  powerManagement.powertop.enable = true;
}
