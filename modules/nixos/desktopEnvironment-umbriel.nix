{ inputs, ... }: {
  #meta.doc = builtins.toFile "doc.md" "Enables the Umbriel desktop environment on your system.";

  imports = [
    inputs.umbriel.nixosModules.default

    ./desktopEnvironment-mustHaves.nix
  ];

  programs.umbriel.enable = true;
}
