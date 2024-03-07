{ ... }: {

  custom = {
    desktops.hyprland = {
      enable = true;

      swayidle.timeout = {
        lock = 0;
        suspend = 0;
      };
    };

    xdg.mimeApps = {
      enable = true;
      archivesApp = "ark.desktop";
      audioVideoApp = "mpv.desktop";
      codeApp = "code.desktop";
      documentsApp = "org.gnome.Evince.desktop";
      imagesApp = "org.gnome.eog.desktop";
    };
  };
}
