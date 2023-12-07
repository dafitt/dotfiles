{ pkgs, ... }: {
  # <https://nixos.wiki/wiki/Printing>

  # Enable CUPS
  services.printing = {
    enable = true;
    drivers = [ pkgs.foomatic-db-ppds ];
  };

  # Avahi’s service discovery facilities
  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  # Graphical user interface for CUPS administration
  programs.system-config-printer.enable = true;
}
