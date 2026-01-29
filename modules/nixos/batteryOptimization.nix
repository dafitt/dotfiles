{
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  services.power-profiles-daemon.enable = false;
  services.tlp = {
    enable = true;
    settings = {
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };
  };

  services.upower = {
    enable = true; # provides power management support to applications
    criticalPowerAction = "Hibernate";
  };

  powerManagement.powertop.enable = true;

  # suspend-then-hibernate
  # sleep.conf.d(5)
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=3h
  '';
  services.logind.settings.Login = {
    # logind.conf(5)
    SleepOperation = "suspend-then-hibernate suspend hibernate";

    HandleLidSwitch = "sleep";
    HandleLidSwitchExternalPower = "sleep";
  };
}
