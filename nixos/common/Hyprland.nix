{ pkgs, hyprland, ... }: {
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.${pkgs.system}.hyprland;

    xwayland.enable = true;
  };

  security.pam.services.swaylock = { }; # [swaylock fix](https://github.com/NixOS/nixpkgs/issues/158025)

  # For GNOME programs outside of GNOME
  programs.dconf.enable = true;
}
