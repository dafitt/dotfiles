{
  #meta.doc = builtins.toFile "doc.md" "Configures systemd on your system.";

  # suspend-then-hibernate
  # sleep.conf.d(5)
  systemd.sleep.settings.Sleep.HibernateDelaySec = "3h";

  services.journald.settings.Journal = {
    SystemMaxUse = "100M";
    MaxFileSec = "7day";
  };
}
