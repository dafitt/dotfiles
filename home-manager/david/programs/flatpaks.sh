LOG_INFO="[\e[1;34m INFO \e[0m]"                                           # [ INFO ]
LOG_OK="[\e[1;32m OK \e[0m]"                                               # [ OK ]
LOG_ERROR="[\e[1;31m ERROR \e[0m]"                                         # [ ERROR ]
trap 'exit' INT                                                            # exit on INTERRUPTION (Ctrl+C)
trap 'echo -e "\n$LOG_ERROR Command failed with exit code $?"; exit 1' ERR # exit on ERROR
cd $(dirname $0)

# Remote repository
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak --user update

# Define your array of Flatpak applications
declare -a flatpaks=(
    "com.github.tchx84.Flatseal"
    "org.gtk.Gtk3theme.adw-gtk3-dark"

    "md.obsidian.Obsidian" # A knowledge base that works with plain Markdown files
    "io.bassi.Amberol"     # Plays music, and nothing else
    "nl.hjdskes.gcolor3"   # Quick color tool
    "dev.aunetx.deezer"
    "com.valvesoftware.Steam"
    "de.shorsh.discord-screenaudio"
    "org.signal.Signal"
    "ch.threema.threema-web-desktop"
    "io.github.mimbrero.WhatsAppDesktop" # WhatsApp client
    "org.x.Warpinator"                   # Send and receive files across the network
    "com.github.rajsolai.textsnatcher"   # Copy text from images
    io.gitlab.adhami3310.Footage         # Trim, flip, rotate and crop individual video clips.
)

# Loop through the array and install or update each Flatpak
for app_name in "${flatpaks[@]}"; do
    if flatpak list | grep -q "$app_name"; then
        echo -e "$LOG_OK $app_name: Already installed."
        tput sc && echo -e "$LOG_INFO Checking for updates..."

        flatpak update --user --noninteractive "$app_name"
        if [ $? -eq 0 ]; then
            tput rc && echo -e "$LOG_OK $app_name: Up-to-date."
        else
            tput rc && echo -e "$LOG_ERROR $app_name: Failed to update."
        fi
    else
        tput sc && echo -e "$LOG_INFO $app_name: Installing..."

        flatpak install --user --noninteractive flathub "$app_name"
        if [ $? -eq 0 ]; then
            tput rc && echo -e "$LOG_OK $app_name: Successfully installed."
        else
            tput rc && echo -e "$LOG_ERROR $app_name: Failed to install."
        fi
    fi
    echo
done
