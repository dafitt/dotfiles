{
  #meta.doc = builtins.toFile "doc.md" "Configures systemd on your system.";

  services.journald.extraConfig = ''
    SystemMaxUse=100M
    MaxFileSec=7day
  '';
}
