{
  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';
}
