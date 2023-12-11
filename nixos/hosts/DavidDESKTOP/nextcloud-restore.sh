LOG_INFO="[\e[1;34m INFO \e[0m]"                                                 # [ INFO ]
LOG_OK="[\e[1;32m OK \e[0m]"                                                     # [ OK ]
LOG_ERROR="[\e[1;31m ERROR \e[0m]"                                               # [ ERROR ]
LOG_ACTION="[\e[1;33m ACTION \e[0m]"                                             # [ ACTION ]
trap 'revert; exit' INT                                                          # exit on INTERRUPTION (Ctrl+C)
trap 'revert; echo -e "$LOG_ERROR Command failed with exit code $?"; exit 1' ERR # exit on ERROR

# Check if the backup archive is provided
if [ -z "$1" ]; then
    echo -e "$LOG_ACTION Usage: $0 <backup_archive>"
    exit 1
fi

echo -e "$LOG_INFO Savely moving current nextcloud data..."
mv "/var/lib/nextcloud" "/var/lib/nextcloud_backup"
revert() {
    echo -e "$LOG_ACTION Reverting..."
    rm -rf "/var/lib/nextcloud"
    mv -f "/var/lib/nextcloud_backup" "/var/lib/nextcloud"
}

echo -e "$LOG_INFO Extracting $1..."
tar -xzvf "$1" -C "/var/lib/nextcloud"
echo -e "$LOG_OK Backup restored!"

echo -e "$LOG_INFO Removing safety backup..."
rm -rf "/var/lib/nextcloud_backup"
echo -e "$LOG_OK Finished!"
