# Host: Micro-Star International Co., Ltd. MEG B550 UNIFY-X (MS-7D13)
# CPU: AMD Ryzen 7 5700X (16) @ 3.400GHz
# GPU: AMD ATI Radeon RX 6650 XT
# Memory: 64GB
# Case: Dark Base 900 Orange
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./connman.nix
    ./zfs.nix
    ./nextcloud.nix
    ./miniDLNA.nix

    ../../users/david.nix
    ../../users/guest.nix

    ../../common/DESKTOP.nix
    ../../common/nix.nix
    ../../common/gamemode.nix
    ../../common/ssh.nix
    ../../common/virtualisation.nix
  ];
}
