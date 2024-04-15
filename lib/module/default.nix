{ lib, ... }:

with lib; rec {
  mkOpt = type: default: description: mkOption { inherit type default description; };
  mkOpt' = type: default: mkOpt type default null; # without description

  mkBoolOpt = mkOpt types.bool;
  mkBoolOpt' = mkOpt' types.bool;
}
