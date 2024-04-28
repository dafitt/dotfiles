#!/usr/bin/env nix shell nixpkgs#bash nixpkgs#hyprkeys nixpkgs#wl-clipboard -c bash

hyprkeys --binds --config-file=$HOME/.config/hypr/hyprland.conf --markdown | sed -E 's/\/nix\/store\/[a-z0-9]{32}-.+\/bin\///g' | wl-copy
