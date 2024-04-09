{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.env;
in
{
  options.dafitt.env = with types; mkOption {
    type = attrsOf (oneOf [ str path (listOf (either str path)) ]);
    apply = mapAttrs (_n: v:
      if isList v
      then concatMapStringsSep ":" toString v
      else (toString v));
    default = { };
    description = "A set of environment variables to set.";
  };

  config = {
    environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
        # To prevent firefox from creating ~/Desktop.
        XDG_DESKTOP_DIR = "$HOME";
      };
      variables = {
        # Make some programs "XDG" compliant.
        LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
        WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      };
      extraInit =
        concatStringsSep "\n"
          (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg);
    };
  };
}
