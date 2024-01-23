{
  #$ sudo systemctl status wg-quick-DavidVPN
  #$ sudo systemctl stop wg-quick-DavidVPN
  #$ sudo systemctl start wg-quick-DavidVPN
  services.connman.networkInterfaceBlacklist = [ "DavidVPN" ];
  networking.wg-quick.interfaces."DavidVPN" = {
    address = [ "fc07::2/64" "10.0.0.2/24" ];
    dns = [ "fd02:f69b:7377:a500::9" "192.168.19.133" ];

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
}
