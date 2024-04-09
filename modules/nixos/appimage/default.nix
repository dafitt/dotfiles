{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.appimage;
in
{
  options.dafitt.appimage = with types; {
    enable = mkBoolOpt false "Enable appimage support";
  };

  config = mkIf cfg.enable {
    # https://nixos.wiki/wiki/Appimage
    environment.systemPackages = with pkgs; [ appimage-run ];

    boot.binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
      magicOrExtension = ''\x7fELF....AI\x02'';
    };
  };
}
