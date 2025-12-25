#!/usr/bin/env nix
#!nix shell
#!nix nixpkgs#perl
#!nix nixpkgs#bash -c bash

# Json / Catppuccin Mocha -> Nix / Stylix (base16)
# https://github.com/Jas-SinghFSU/HyprPanel/blob/master/themes/catppuccin_mocha_vivid.json
# https://github.com/catppuccin/catppuccin
# https://github.com/catppuccin/base16/blob/main/assets/base16.png
perl -p -g -i -e '
    s/,$/;/g;
    s/": "/" = "/g;
    s/"#11111(a|b)"/base00/g;
    s/"#1e1e2e"/base00/g;
    s/"#18182(4|5|6)"/base01/g;
    s/"#2(3|4)2(3|4)38"/base02/g;
    s/"#31324(3|4|5)"/base02/g;
    s/"#45475(9|a)"/base03/g;
    s/"#585b7(0|1)"/base04/g;
    s/"#6c7086"/base04/g;
    s/"#7f849b"/base04/g;
    s/"#9399b2"/base04/g;
    s/"#cdd6f(3|4)"/base05/g;
    s/"#caa6f7"/base05/g;
    s/"#b4bef(d|e|f)"/base07/g;
    s/"#f38ba(7|8)"/base08/g;
    s/"#eba0a(b|c|d)"/base08/g;
    s/"#fab387"/base09/g;
    s/"#f9e2a(e|f)"/base0A/g;
    s/"#a6e3a(1|2)"/base0B/g;
    s/"#89d(b|c)e(a|b)"/base0C/g;
    s/"#94e2d(4|5|6)"/base0C/g;
    s/"#89b4fa"/base0D/g;
    s/"#cba6f(6|7)"/base0E/g;
    s/"#f5c2e(6|7|8)"/base0F/g;
    s/"#f2cdcd"/base0F/g;
    ' $(dirname $0)/default.nix
