{ inputs, ... }:

#> nixosConfigurations.TT-WCN13114.config
{
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "26.05";

  imports =
    with inputs;
    with self.nixosModules;
    [
      nixos-wsl.nixosModules.default

      audio
      desktopEnvironment-umbriel
      development
      documentation
      fonts
      home-manager
      hostName
      locale
      locate
      nix
      shell-fish
      stylix
      sudo
      systemd
      time
      user-root
    ];

  wsl = {
    enable = true;
    useWindowsDriver = true;
    docker-desktop.enable = true;
    startMenuLaunchers = true;
  };
  security.sudo-rs.wheelNeedsPassword = false;

  # WSL Settings > Network > Mode > "mirrored" needed
  users.users.cntlm.group = "cntlm";
  users.groups.cntlm = {};
  services.cntlm = {
    enable = true;
    username = "sdc2tt";
    domain = "tt.de.bosch.com";
    password = "/etc/cntlm.password";
    # $ nix run nixpkgs#cntlm -- -H

    port = [ 3129 ];
    proxy = [ "rb-proxy-de.bosch.com:8080" ];
    noproxy = [
      "127.0.0.1"
      "localhost"
      "127.*"
      "172.*"
      "192.168.50.1"
      ".bshg.com"
      ".bosch.com"
    ];
  };
  networking.proxy = {
    httpProxy = "http://127.0.0.1:3129";
    httpsProxy = "http://127.0.0.1:3129";
    noProxy = "127.0.0.1,localhost,127.*,172.*,192.168.50.1,.bshg.com,.bosch.com";
  };

  fileSystems = {
    "/mnt/f" = {
      device = "F:";
      fsType = "drvfs";
      noCheck = true;
      options = [
        "_netdev"
        "defaults"
        "noauto"
        "users"
        "x-mount.mkdir"
        "x-systemd.automount"
      ];
    };
    "/mnt/u" = {
      device = "U:";
      fsType = "drvfs";
      noCheck = true;
      options = [
        "_netdev"
        "defaults"
        "noauto"
        "users"
        "x-mount.mkdir"
        "x-systemd.automount"
      ];
    };
  };
}
