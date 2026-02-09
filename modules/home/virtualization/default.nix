{
  #meta.doc = builtins.toFile "doc.md" "A suite of virtualization tools and applications.";

  imports = [
    ./quickemu.nix
  ];
}
