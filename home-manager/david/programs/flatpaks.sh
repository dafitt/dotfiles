# Remote repository
flatpak --user remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Define your array of Flatpak applications
declare -a flatpaks=(
    "com.github.tchx84.Flatseal"
    "org.gtk.Gtk3theme.adw-gtk3-dark"

    "md.obsidian.Obsidian" # a knowledge base that works with plain Markdown files
    "io.bassi.Amberol"     # plays music, and nothing else
    "nl.hjdskes.gcolor3"   # quick color tool
    "com.valvesoftware.Steam"
    "de.shorsh.discord-screenaudio"
    "org.signal.Signal"
    "ch.threema.threema-web-desktop"
    "io.github.mimbrero.WhatsAppDesktop" # WhatsApp client
    "org.x.Warpinator"                   # send and receive files across the network
    "com.github.rajsolai.textsnatcher"   # copy text from images
)

# Loop through the array and install or update each Flatpak
for app_name in "${flatpaks[@]}"; do
    if flatpak list | grep -q "$app_name"; then
        echo "[$app_name]: Already installed."
        echo "[$app_name]: Checking for updates..."
        flatpak update --user --noninteractive "$app_name"
        if [ $? -eq 0 ]; then
            echo "[$app_name]: Updated."
        else
            echo "[$app_name]: Failed to update."
        fi
    else
        echo "[$app_name]: Installing..."
        flatpak install --user --noninteractive flathub "$app_name"
        if [ $? -eq 0 ]; then
            echo "[$app_name]: Successfully installed."
        else
            echo "[$app_name]: Failed to install $app_name."
        fi
    fi
    echo
done
