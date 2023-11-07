# a minimal host configuration

{ config, lib, pkgs, ... }: {


  imports = [
    # FIXME import nixos-hardware
    #<nixos-hardware/common/cpu/amd>
    #<nixos-hardware/common/gpu/amd>
    ../hardware-configuration.nix
    ../shared-desktop.nix
  ];


  boot.loader = {
    systemd-boot.enable = true;
    grub = {
      enable = false;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;

    # Skip the boot selection menu. [space] to open it.
    timeout = 0;
  };


  console.keyMap = "de-latin1-nodeadkeys";


  boot.kernel.sysctl = { "vm.swappiness" = 10; }; # reduce swappiness

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 35 * 1024; # in MiB
  }];


  networking = {
    hostName = "DavidLEGION"; # Define your hostname.

    firewall = {
      allowedTCPPorts = [
        #25 465 587 # SMTP
        #143 993 # IMAP
        22000 # syncthing
      ];
      allowedUDPPorts = [
        21027 # syncthing broadcast
        22000 # syncthing
      ];
      allowedTCPPortRanges = [
        #{ from = 27015; to = 27050; } # Steam
      ];
      allowedUDPPortRanges = [
        #{ from = 27015; to = 27050; } # Steam
      ];
    };
  };


  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };


  services = {

    fstrim.enable = true; # SSD

    thermald.enable = true; # Cooling management, prevents overheating

    tlp = {
      # power management daemon
      # docs <https://linrunner.de/tlp/>
      enable = true;
      settings = {
        # battery care
        STOP_CHARGE_THRESH_BAT0 = 1;

        # graphics
        RADEON_DPM_STATE_ON_AC = "performance";
        RADEON_DPM_STATE_ON_BAT = "battery";

        # kernel
        NMI_WATCHDOG = 0;

        # profile
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";

        # processor
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_SCALING_MIN_FREQ_ON_AC = 0;
        CPU_SCALING_MAX_FREQ_ON_AC = 3200000;
        CPU_SCALING_MIN_FREQ_ON_BAT = 0;
        CPU_SCALING_MAX_FREQ_ON_BAT = 1600000;
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
      };
    };

    logind.extraConfig = ''
      HandlePowerKey=suspend
    '';

    upower = {
      enable = true; # provides power management support to applications
      criticalPowerAction = "Hibernate";
    };

    # TODO thinkfan = {
    #  enable = true;
    #};
    # man tinkfan 1/5

    udev.enable = true;
    udev.extraRules = lib.mkMerge [
      # diable wakeup <https://nixos.wiki/wiki/Power_Management#System_Immediately_wakes_up_from_suspend>
      #$ cat /proc/acpi/wakeup
      ''ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"''
      # diable wakeup: USB XHC0 (Keyboard)
      ''ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x161d" ATTR{power/wakeup}="disabled"''
      # diable wakeup: USB XHC1 (external Mouse)
      ''ACTION=="add" SUBSYSTEM=="pci" ATTR{vendor}=="0x1022" ATTR{device}=="0x161e" ATTR{power/wakeup}="disabled"''
      # TODO disable wakeup: LID

      # autosuspend USB devices
      #''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
      # autosuspend PCI devices
      ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
      # disable Ethernet Wake-on-LAN
      ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''
    ];

    blueman.enable = true;

  };


  powerManagement.enable = true; # stock NixOS power management: hibernate & suspend


  # Discrete Graphics
  #$$ env DRI_PRIME=1 [command] {args}


  system.stateVersion = "23.05"; # Do not touch
}
