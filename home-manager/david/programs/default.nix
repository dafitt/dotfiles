{ lib, pkgs, ... }:

# <https://www.reddit.com/r/NixOS/comments/j5pa9o/getting_all_configs_from_folder/>
# <https://github.com/infinisil/system/blob/df9232c4b6cec57874e531c350157c37863b91a0/config/new-modules/default.nix>
with lib;
let
  # Recursively constructs an attrset of a given folder, recursing on directories, value of attrs is the filetype
  getDir = dir: mapAttrs
    (file: type:
      if type == "directory" then getDir "${dir}/${file}" else type
    )
    (builtins.readDir dir);

  # Collects all files of a directory as a list of strings of paths
  files = dir: collect isString (mapAttrsRecursive (path: type: concatStringsSep "/" path) (getDir dir));

  # Filters out directories that don't end with .nix or are this file, also makes the strings absolute
  validFiles = dir: map (file: ./. + "/${file}")
    (filter
      (file:
        hasSuffix ".nix" file &&
        file != "default.nix" &&
        ! lib.hasPrefix "." file &&
        ! lib.hasSuffix "~.nix" file
      )
      (files dir));
in
{
  # Import all *.nix files in this directory
  imports = validFiles ./.;

  # Some packages to install
  home.packages = with pkgs; [
    # search packages here: <https://search.nixos.org/packages>

    clapper # a simple and modern GNOME media player
    gnome.gnome-characters # character picker
    hunspell # Spell checking
    hunspellDicts.de_DE
    hunspellDicts.en_US-large
    libreoffice-fresh # office suite
    tenacity # Sound editor with graphical UI

    # for development and administration
    gnome.dconf-editor
    gnome.gnome-tweaks
    gnome.gnome-nettool
    gnome.gucharmap # to search unicode characters
    pandoc # document converter
    wireshark # network protocol analyzer
  ];
}
