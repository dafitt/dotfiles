{ channels, ... }:

final: prev:
with channels.unstable; {
  # packages to get from inputs.unstable
  inherit
    gamescope
    lutris
    ;
}
