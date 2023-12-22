{ lib, pkgs, ... }: {
  # A secondary browser for opening Links in Wayland
  # See <https://librewolf.net/docs/faq/#cant-open-links-with-librewolf-when-using-wayland>
  home.packages = [ pkgs.epiphany ];

  xdg.mimeApps.defaultApplications =
    let
      mimetypes = [
        "text/html"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
        "x-scheme-handler/about"
        "x-scheme-handler/unknown"
      ];
    in
    (lib.genAttrs mimetypes (_: [ "org.gnome.Epiphany.desktop" ]));
}
