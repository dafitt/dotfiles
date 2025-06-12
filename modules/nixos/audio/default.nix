{ config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.audio;
in
{
  options.dafitt.audio = with types; {
    enable = mkEnableOption "audio with the pipewire sound server";
  };

  config = mkIf cfg.enable {
    # https://wiki.nixos.org/wiki/PipeWire
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

    programs.noisetorch.enable = true; # creates a virtual microphone that suppresses noise in any application
  };
}
