{ config, ... }: {
  services.connman = {
    enable = true;
    wifi.backend = "iwd";
    extraConfig = ''
      [General]
      PreferredTechnologies=ethernet,wifi
    '';

    networkInterfaceBlacklist = [ "vmnet" "vboxnet" "virbr" "ifb" "ve" ];
  };
}
