{ config, lib, pkgs, ... }: {

  # Multi-platform password manager
  # https://1password.com/
  home.packages = [ pkgs._1password-gui ];

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, PERIOD, exec, ${pkgs._1password-gui}/bin/1password" ];
    windowrulev2 = [
      "float, class:1Password, title:1Password"
      "size 600 900, class:1Password, title:1Password"
      "move 70% 10%, class:1Password, title:1Password"

      "center, class:1Password, title:(Lock Screen)"
      "size 600 450, class:1Password, title:(Lock Screen)"
    ];
    # titles: Lock Screen — 1Password ; All Items — 1Password ; 
  };
}
