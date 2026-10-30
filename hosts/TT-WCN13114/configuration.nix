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

  # wsl.wslConf.network.generateResolvConf = false;
  # networking = {
  #   nameservers = [
  #     "1.1.1.1"
  #     "1.0.0.1"
  #     "10.255.255.254"
  #   ];
  #   search = [
  #     "de.bosch.com"
  #     "bsh.corp.bshg.com"
  #     "tt.de.bosch.com"
  #     "bosch.com"
  #   ];
  #   # proxy = {
  #   #  default = "http://rb-proxy-de.bsh.corp.bshg.com:8080";
  #   #  ftpProxy = "http://rb-proxy-de.bsh.corp.bshg.com:8081";
  #   # };
  # };

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
