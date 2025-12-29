{
  programs.niri.enable = true;
  programs.uwsm.enable = true;

  programs.uwsm.waylandCompositors = {
    niri = {
      prettyName = "Niri";
      comment = "Niri compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/niri --session";
    };
  };

  security.soteria.enable = true;
}
