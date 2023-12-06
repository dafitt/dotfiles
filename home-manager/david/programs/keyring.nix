{ config, lib, pkgs, ... }: {

  home.packages = [ pkgs.gnome.seahorse ];

  services.gnome-keyring = {
    enable = true;
    #components = [ "pkcs11" "secrets" "ssh" ];
  };


  # GNU Privacy Guard, a GPL OpenPGP implementation
  # <https://gnupg.org>
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
    #enableSshSupport = true;
  };
}
