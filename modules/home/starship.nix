{
  #meta.doc = builtins.toFile "doc.md" ''
  #  Installs and configures the Starship prompt for any shell.
  #  <https://starship.rs/>
  #'';

  programs.starship = {
    enable = true;

    settings = {
      # https://starship.rs/config
      cmd_duration = {
        format = "";
        min_time_to_notify = 450000;
        show_notifications = true;
      };
      #os.disabled = false;
      time = {
        disabled = false;
        format = "[$time]($style)";
        time_format = "%H:%M:%S ";
      };
    };
  };
}
