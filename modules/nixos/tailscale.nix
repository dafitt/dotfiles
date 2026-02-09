{
  #meta.doc = builtins.toFile "doc.md" "Installs and configures tailscale on your system.";

  services.tailscale.enable = true;
}
