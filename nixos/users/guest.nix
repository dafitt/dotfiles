{ pkgs, home-manager, ... }: {

  imports = [ home-manager.nixosModules.home-manager ];

  # Enable GNOME
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludePackages = with pkgs.gnome; [
    geary # email reader
  ];

  # Guest account
  users.users."guest" = {
    isNormalUser = true;
    password = "guest";
  };

  # Autostart GNOME from tty
  home-manager.users."guest" = {
    home.packages = [ pkgs.gnome.gnome-session ];

    home.file.".bash_profile".text = ''
      # include .profile if it exists
      [[ -f ~/.profile ]] && ~/.profile

      # inlude .bashrc if it exists
      [[ -f ~/.bashrc ]] && ~/.bashrc

      # Starting gnome session on tty-login
      if [[ -z $DISPLAY && $(tty) =~ /dev/tty[1-4] && $XDG_SESSION_TYPE == tty ]]; then
        MOZ_ENABLE_WAYLAND=1 QT_QPA_PLATFORM=wayland XDG_SESSION_TYPE=wayland exec dbus-run-session gnome-session
      fi
    '';

    home.stateVersion = "23.11";
  };
}
