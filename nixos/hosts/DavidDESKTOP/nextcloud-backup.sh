LOG_INFO="[\e[1;34m INFO \e[0m]"                                         # [ INFO ]
LOG_OK="[\e[1;32m OK \e[0m]"                                             # [ OK ]
LOG_ERROR="[\e[1;31m ERROR \e[0m]"                                       # [ ERROR ]
LOG_ACTION="[\e[1;33m ACTION \e[0m]"                                     # [ ACTION ]
trap 'exit' INT                                                          # exit on INTERRUPTION (Ctrl+C)
trap 'echo -e "$LOG_ERROR Command failed with exit code $?"; exit 1' ERR # exit on ERROR

# Check if the backup path is provided
if [ -z "$1" ]; then
    echo -e "$LOG_ACTION Usage: $0 <backup_path>"
    exit 1
fi

echo -e "$LOG_INFO Archiving /var/lib/nextcloud..."
# TODO /var/lib/nextcloud -> config.services.nextcloud.home
tar -czvf "$1/nextcloud_$(date '+%Y-%m-%d_%H%M%S').tar.gz" -C "/var/lib/nextcloud" .

echo -e "$LOG_OK Archive saved to: $1"

# TODO protect archive with admin password
