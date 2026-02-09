{ pkgs, ... }:
{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Adds security scanning tools to your system.

  #  Update the virus database with `freshclam`.
  #  Scan your system or directories with `clamscan`.
  #'';

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
