{
  services.connman.networkInterfaceBlacklist = [ "DavidVPN" ];
  networking.wireguard.interfaces."DavidVPN" = {

    ips = [ "10.0.0.2/24" "fc07:32a8:2fea:19eb::2/64" ];
    listenPort = 51820; # to match firewalls' allowedUDPPorts (without -> random port numbers)

    generatePrivateKeyFile = true;
    privateKeyFile = "/var/lib/wireguard/private.key";
    #$ wg pubkey < /var/lib/wireguard/private.key > /var/lib/wireguard/public.key

    peers = [{
      # DavidVPN Server
      endpoint = "htdth4b8vgtu5dym.myfritz.net:123"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577
      publicKey = "UVLXpDHXGdolVpVWB0Vt0YWVr0HFkhZGpsK72pXFTww=";
      # Which traffic to forward
      allowedIPs = [ "192.168.18.0/23" "fd02:f69b:7377:a500::/56" ];
      persistentKeepalive = 25; # Important to keep NAT tables alive.
    }];
  };

  networking.firewall = {
    allowedUDPPorts = [ 51820 ]; # Clients and peers can use the same port, see listenport
  };
}
