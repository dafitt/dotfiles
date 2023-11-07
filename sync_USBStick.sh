USBSTICK=/run/media/david/DavidSTICK/NixOS-hm-standalone
FOLDER=~/Desktop/NixOS-hm-standalone

PS3="What is the more recent directory? [number]>"
#TODO options=(
#    "NONE, dont delete any files (sync only)"
#    USBSTICK
#    FOLDER
#    quit
#)
select opt in NONE USBSTICK FOLDER quit; do

    case $REPLY in
    1) # Sync only, dont delete any files
        rsync --archive --update --progress -vh $USBSTICK/ $FOLDER
        rsync --archive --update --progress -vh $FOLDER/ $USBSTICK
        exit
        ;;
    2) # copy from USB to folder
        rsync --archive --update --delete --progress -vh $USBSTICK/ $FOLDER
        exit
        ;;
    3) # copy from folder to USB
        rsync --archive --update --delete --progress -vh $FOLDER/ $USBSTICK
        exit
        ;;
    *)
        exit
        ;;
    esac
done
