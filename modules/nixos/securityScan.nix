{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    clamav
    lynis
  ];

  services.clamav.daemon.enable = true;
  # services.clamav.scanner.enable = true;
  # Manually:
  #$ clamscan
  # services.clamav.updater.enable = true;
  # Manually:
  #$ sudo freshclam
}
