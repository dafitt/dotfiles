{ pkgs, ... }: {
  #$ sudo systemctl status wg-quick-DavidVPN
  #$ sudo systemctl stop wg-quick-DavidVPN
  #$ sudo systemctl start wg-quick-DavidVPN
  services.connman.networkInterfaceBlacklist = [ "DavidVPN" ];
  networking.wg-quick.interfaces."DavidVPN" = {
    address = [ "fc07::2/64" "10.0.0.2/24" ];
    dns = [ "fd02:f69b:7377:a500::8" "192.168.19.132" ];

    #$ (umask 0077; wg genkey > /var/lib/wireguard/private.key)
    privateKeyFile = "/var/lib/wireguard/private.key";

    #$ wg pubkey < /var/lib/wireguard/private.key
    # D90wpk+4Hwpvnmq8JUqcjoph1tswJ5sZRKwvmKSlLnw=

    peers = [{
      # DavidVPN Server
      endpoint = "david.wireguard.schallernetz.de:123";
      publicKey = "D90wpk+4Hwpvnmq8JUqcjoph1tswJ5sZRKwvmKSlLnw=";
      # Which traffic to forward
      allowedIPs = [ "fd02:f69b:7377:a500::/56" "192.168.18.0/23" ];
      persistentKeepalive = 25; # Important to keep NAT tables alive.
    }];
  };

  systemd.services."wg-quick-DavidVPN-restart" = {
    description = "restart DavidVPN"; # because of endpoint's dyndns
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [ "nss-lookup.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl restart wg-quick-DavidVPN";
      Restart = "on-failure";
    };
  };
  systemd.timers."wg-quick-DavidVPN-restart" = {
    wantedBy = [ "timers.target" ];
    wants = [ "network-online.target" ];
    after = [ "nss-lookup.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };
}
