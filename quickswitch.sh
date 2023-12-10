LOG_INFO="[\e[1;34m INFO \e[0m]"                                           # [ INFO ]
LOG_ERROR="[\e[1;31m ERROR \e[0m]"                                         # [ ERROR ]
trap 'exit 1' INT                                                          # exit on INTERRUPTION (Ctrl+C)
trap 'echo -e "\n$LOG_ERROR Command failed with exit code $?"; exit 1' ERR # exit on ERROR
cd $(dirname $0)                                                           # working directory of file

echo -e "\n$LOG_INFO Building system..."
sudo nixos-rebuild switch --flake .

echo -e "\n$LOG_INFO Building home..."
home-manager switch --flake .

echo -e "\n[\e[1;32m SUCESS \e[0m]"
