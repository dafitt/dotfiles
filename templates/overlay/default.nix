{ channels, ... }:

final: prev: {
  package = prev.package.override { };
}
