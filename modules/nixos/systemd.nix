{
  meta.doc = "Configures systemd on your system.";

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';
}
