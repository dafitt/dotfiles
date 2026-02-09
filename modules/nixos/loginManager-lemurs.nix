{
  #meta.doc = builtins.toFile "doc.md" "Enables and configures the login manager Lemurs.";

  services.displayManager.lemurs = {
    enable = true;
  };

  # https://codeberg.org/fairyglade/ly/issues/727
  systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
}
