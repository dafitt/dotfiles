{
  #$$ sudo nixos-container start nextcloud
  #$$ sudo nixos-container root-login nextcloud

  containers.nextcloud = {
    autoStart = false;

    config = { config, lib, pkgs, ... }: {

      services.nextcloud = {
        enable = true;
        package = pkgs.nextcloud27; # UPDATE: Only increment by 1!
        extraApps = with config.services.nextcloud.package.packages.apps; {
          inherit contacts calendar tasks;
        };

        hostName = "localhost";

        config.adminuser = "david"; # Cannot be changed later!
        config.adminpassFile = "${pkgs.writeText "adminpwd" "test123"}"; # TODO NixOS-sops

        maxUploadSize = "20M";
      };


      #networking = {
      #  firewall = {
      #    enable = true;
      #    allowedTCPPorts = [ 80 ];
      #  };
      #   Use systemd-resolved inside the container
      #  useHostResolvConf = lib.mkForce false;
      #};
      #services.resolved.enable = true;


      system.stateVersion = "23.11";
    };
  };

}
