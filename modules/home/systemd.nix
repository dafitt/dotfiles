{
  #meta.doc = builtins.toFile "doc.md" "Configures systemd user settings.";

  systemd.user.settings.Manager = {
    #$ man systemd-user.conf

    # reduce restart rate limiting time
    DefaultStartLimitIntervalSec = "2s";
  };
}
