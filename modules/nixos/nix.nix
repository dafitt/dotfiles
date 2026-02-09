{
  #meta.doc = builtins.toFile "doc.md" "Configures the Nix package manager on your system.";

  imports = [ ../home/nix.nix ]; # Compatibility with home-manager standalone

  nix.channel.enable = false; # we use flakes instead
}
