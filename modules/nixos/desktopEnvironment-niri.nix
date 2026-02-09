{
  meta.doc = "Enables and configures the Niri desktop environment on your system.";

  imports = [
    ./desktopEnvironment-mustHaves.nix
  ];

  programs.niri.enable = true;
  programs.uwsm.enable = true;

  programs.uwsm.waylandCompositors = {
    niri = {
      prettyName = "Niri";
      comment = "Niri compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/niri --session";
    };
  };
}
