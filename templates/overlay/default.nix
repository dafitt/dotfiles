{ channels, inputs, ... }:

# https://snowfall.org/guides/lib/overlays/
# https://wiki.nixos.org/wiki/Overlays
# final: nixpkgs with your overlay applied
# prev: nixpkgs without your overlay
final: prev: {

  # use package from unstable
  PACKAGE_UNSTABLE = channels.unstable.PACKAGE_UNSTABLE;

  # use package from another flake
  PACKAGE_FLAKE = inputs.PACKAGE_FLAKE.packages.${prev.system}.PACKAGE_FLAKE;

  # package override
  PACKAGE_OVERRIDE_OPTION = prev.PACKAGE_OVERRIDE_OPTION.override { x11Support = false; };
  PACKAGE_OVERRIDE_ATTRS = prev.PACKAGE_OVERRIDE_ATTRS.overrideAttrs (oldAttrs: { src = prev.fetchFromGitHub { }; });
  PACKAGE_OVERRIDE_EXTEDND = prev.PACKAGE_OVERRIDE_EXTEDND.extend (final': prev': { });
}
