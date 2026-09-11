{
  #meta.doc = builtins.toFile "doc.md" "Configures systemd on your system.";

  services.journald.settings.Journal = {
    SystemMaxUse = "100M";
    MaxFileSec = "7day";
  };
}
