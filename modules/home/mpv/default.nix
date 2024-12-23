{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.mpv;
in
{
  options.dafitt.mpv = with types; {
    enable = mkBoolOpt true "Whether to enable mpv, a free, open source, and cross-platform media player.";
    defaultApplication = mkBoolOpt true "Set mpv as the default application for its mimetypes";
  };

  config = mkIf cfg.enable {
    # https://mpv.io/
    programs.mpv.enable = true;

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "mpv.desktop" ]; }) [
      "video/mp4"
      "video/webm"
      "video/ogg"
      "video/x-matroska"
      "video/x-flv"
      "video/x-msvideo"
      "video/x-ms-wmv"
      "video/x-ms-asf"
      "video/x-dv"
      "video/x-dvd"
      "video/x-vcd"
      "video/x-svcd"
      "video/x-divx"
      "video/x-xvid"
      "video/x-h264"
      "video/x-theora"
      "video/x-vp8"
      "video/x-vp9"
      "video/x-avc"
      "video/x-hevc"
      "video/x-dnxhd"
      "video/x-vc1"
      "video/x-wmv9"
      "video/x-wmv3"
      "video/x-wmv2"
      "video/x-ms-asx"
      "video/x-rtsp"
      "video/x-mjpeg"
      "video/x-dvbsub"
      "video/x-pva"
      "video/x-wmv"
      "video/x-msvideo"
      "video/x-ms-asf"
      "video/x-dv"
      "video/x-dvd"
      "video/x-vcd"
      "video/x-svcd"
      "video/x-divx"
      "video/x-xvid"
      "video/x-h264"
      "video/x-theora"
      "video/x-vp8"
      "video/x-vp9"
      "video/x-avc"
      "video/x-hevc"
      "video/x-dnxhd"
      "video/x-vc1"
      "video/x-wmv9"
      "video/x-wmv3"
      "video/x-wmv2"
      "video/x-ms-asx"
      "video/x-rtsp"
      "video/x-mjpeg"
      "video/x-dvbsub"
      "video/x-pva"
      "audio/mp3"
      "audio/ogg"
      "audio/wav"
      "audio/flac"
      "audio/aac"
      "audio/ac3"
      "audio/dts"
      "audio/vorbis"
      "audio/opus"
      "audio/flac"
      "audio/amr"
      "audio/speex"
      "audio/silk"
      "audio/midi"
      "audio/x-wav"
      "audio/x-aiff"
      "audio/x-flac"
      "audio/x-vorbis"
      "audio/x-opus"
      "audio/x-amr"
      "audio/x-speex"
      "audio/x-silk"
      "audio/x-midi"
      "application/x-subrip"
      "application/x-ass"
      "application/x-vobsub"
      "application/x-pgs"
      "application/x-dvdsub"
      "application/x-pjs"
      "application/x-jacosub"
      "application/x-mpsub"
      "application/x-3gpp"
      "application/x-mpeg"
      "application/x-ms-wmv"
      "application/x-ms-asf"
      "application/x-shockwave-flash"
      "application/x-director"
      "application/x-quicktimeplayer"
      "application/x-vlc-plugin"
      "application/x-mplayer2"
      "application/x-mplayer"
      "application/x-smplayer"
      "application/x-gstreamer"
      "application/x-aria2"
    ]));


    wayland.windowManager.hyprland.settings = {
      windowrulev2 = [
        "idleinhibit focus, class:mpv" #
      ];
    };
  };
}
