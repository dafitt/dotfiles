# <https://wiki.hyprland.org/Configuring/Monitors/>
# <https://wiki.hyprland.org/hyprland-wiki/pages/Configuring/Advanced-config/#monitors>

#$$ nix-shell -p xorg.xrandr --run xrandr

# monitor=name,resolution{preferred,highres,highrr,disable},position,scale
# ,transform,1
# ,mirror,[NAME]
# ,bitdepth,10
# ,vrr,[0]

case $HOSTNAME in
"DavidDESKTOP")
    hyprctl keyword monitor HDMI-A-1,disabled
    hyprctl keyword monitor DP-1,2560x1440@144,0x0,1
    ;;
"DavidLEGION")
    hyprctl keyword monitor eDP-2,preferred@144,auto,1.25
    #hyprctl keyword monitor HDMI-A-1,preferred,auto,auto
    hyprctl keyword misc:disable_autoreload true
    ;;
"DavidTUX")
    hyprctl keyword monitor eDP-1,1920x1080,auto,1
    hyprctl keyword monitor DP-1,preferred,auto,auto
    hyprctl keyword misc:disable_autoreload true
    ;;
esac
