#!/usr/bin/env nix
#!nix shell
#!nix nixpkgs#hyprkeys
#!nix nixpkgs#ripgrep
#!nix nixpkgs#wl-clipboard
#!nix nixpkgs#bash -c bash

# Just execute this script to update the README.md with the latest hyprkeys table
# ./README.hyprkeys.sh

hyprkeysTable_regex='\| Keybind +\| Dispatcher +\| Command +\|\n(\| -+ ){3}\|\n.+ \|'
hyprkeysTable_new=$(hyprkeys --binds --config-file=$HOME/.config/hypr/hyprland.conf --markdown | sed -E 's/\/nix\/store\/[a-z0-9]{32}-.+\/bin\///g')

README_updated=$(rg --replace "$hyprkeysTable_new" --passthru --no-line-number --multiline --multiline-dotall --regexp "\n$hyprkeysTable_regex" README.md)

echo "$README_updated" >README.md

git reset
git add README.md
git commit --message "readme: updated hyprkeys"
