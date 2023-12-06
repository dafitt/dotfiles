{
  # mount daemon
  services.udiskie = {
    enable = true;
    notify = false;
    settings = {
      icon_names.media = [ "media-optical" ];
    };
  };
}
