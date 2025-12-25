{ inputs, ... }:

inputs.nixos-generators.nixosGenerate {
  system = "x86_64-linux";

  # optional arguments:
  # explicit nixpkgs and lib:
  # pkgs = nixpkgs.legacyPackages.x86_64-linux;
  # lib = nixpkgs.legacyPackages.x86_64-linux.lib;
  # additional arguments to pass to modules:
  # specialArgs = { myExtraArg = "foobar"; };
  modules =
    with inputs;
    with inputs.self.nixosModules;
    [
      # automatically applied by inputs.nixos-generators:
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-base.nix
      # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/installation-device.nix

      SHARED
      development
      fwupd

      {
        isoImage.squashfsCompression = "zstd"; # -Xcompression-level 1..22

        #TODO autologin main user?
      }
    ];

  format = "install-iso";
}
