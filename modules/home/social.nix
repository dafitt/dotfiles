{ ... }:
{
  #meta.doc = builtins.toFile "doc.md" "A suite for social media applications.";

  services.flatpak.packages = [
    "io.github.spacingbat3.webcord"
    "org.gnome.Fractal"
    "org.signal.Signal"
    "io.github.mimbrero.WhatsAppDesktop"
  ];
}
