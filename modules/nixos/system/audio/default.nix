{ options, config, lib, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.system.audio;
in
{
  options.custom.system.audio = with types; {
    enable = mkBoolOpt true "Enable audio through pipewire";
  };

  config = mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      wireplumber.enable = true;
      jack.enable = true;
      pulse.enable = true;
    };
    programs.noisetorch.enable = true;
  };
}
