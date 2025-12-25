{
  #$ sudo nixos-container start minidlna
  #$ sudo nixos-container root-login minidlna
  containers.minidlna = {
    autoStart = false;

    bindMounts = {
      recordings = {
        hostPath = "/DavidARCHIVE/priv/Historie";
        mountPoint = "/mnt/media/Aufnahmen";
        isReadOnly = true;
      };
      videos = {
        hostPath = "/home/david/Videos";
        mountPoint = "/mnt/media/Editing";
        isReadOnly = true;
      };
    };

    config =
      { pkgs, ... }:
      {
        services.minidlna = {
          enable = true;

          openFirewall = true;
          settings = {
            friendly_name = "DavidDESKTOP";
            media_dir = [
              "/mnt/media/Aufnahmen"
              "V,/mnt/media/Editing"
            ];

            # 'yes' to automatically discover new files under media_dir
            # make sure "inotify-tools" packages is installed
            inotify = "yes";

            # Support for streaming .jpg and .mp3 files to a TiVo supporting HMO.
            #enable_tivo = "yes";
          };
        };

        environment.systemPackages = with pkgs; [
          inotify-tools
          minidlna
        ];

        system.stateVersion = "23.11";
      };
  };
}
