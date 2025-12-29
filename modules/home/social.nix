{ inputs, ... }:
{
  imports = with inputs; [
    self.homeModules.flatpak
  ];

  services.flatpak.packages = [
    "io.github.spacingbat3.webcord"
    "org.gnome.Fractal"
    "org.signal.Signal"
    "io.github.mimbrero.WhatsAppDesktop"
    "ch.threema.threema-web-desktop"
  ];
}
