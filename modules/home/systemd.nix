{
  systemd.user.settings.Manager = {
    #$ man systemd-user.conf

    # reduce restart rate limiting time
    DefaultStartLimitIntervalSec = "2s";
  };
}
