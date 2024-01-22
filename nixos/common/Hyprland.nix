{ pkgs, hyprland, ... }: {

  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;

    xwayland.enable = true;
  };

  security.pam.services.swaylock = { }; # [swaylock fix](https://github.com/NixOS/nixpkgs/issues/158025)

  services = {
    gvfs = {
      enable = true; # userspace virtual filesystem (to be able to browse remote resources)
      package = pkgs.gvfs;
    };
    udisks2 = {
      enable = true; # to allow applications to query and manipulate storage devices
      settings = {
        "udisks2.conf".defaults = {
          allow = "exec";
        };
      };
    };
  };
}
