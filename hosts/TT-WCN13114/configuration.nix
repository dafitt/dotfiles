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

      appimage
      audio
      documentation
      flatpak
      fonts
      home-manager
      hostName
      kernel
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

  wsl.enable = true;
  security.sudo-rs.wheelNeedsPassword = false;

  networking.proxy = {
    httpProxy = "http://rb-proxy-de.bsh.corp.bshg.com:8080";
    httpsProxy = "http://rb-proxy-de.bsh.corp.bshg.com:8080";
    ftpProxy = "http://rb-proxy-de.bsh.corp.bshg.com:8081";
  };
}
