{ pkgs, ... }:
{
  # https://wiki.nixos.org/wiki/Printing

  # Enable CUPS
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      splix
      #foomatic-db-ppds
    ];
  };

  # Avahi’s service discovery facilities
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Graphical user interface for CUPS administration
  programs.system-config-printer.enable = true;
}
