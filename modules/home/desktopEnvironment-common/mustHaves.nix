{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Configures common must-haves for every desktop environment.
  #  <https://wiki.hypr.land/Useful-Utilities/Must-have/>
  #'';

  # Auto-mounting
  services.udiskie = {
    enable = true;
    settings = {
      device_config = [
        {
          options = [
            "noatime"
            "noexec"
          ];
        }
      ];
      notifications.timeout = 0.5;
    };
  };

}
