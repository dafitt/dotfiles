{
  #meta.doc = builtins.toFile "doc.md" "Adds Tailscale control.";

  services.tailscale-systray.enable = true;
}
