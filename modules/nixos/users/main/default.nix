{ options, config, lib, pkgs, inputs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.users.main;

  # profile picture
  faceFileName = "face.png";
  face = pkgs.stdenvNoCC.mkDerivation {
    name = "face";
    src = ./. + "/${faceFileName}";
    dontUnpack = true;
    installPhase = ''
      cp $src $out
    '';
    passthru = { fileName = faceFileName; };
  };
in
{
  options.dafitt.users.main = with types; {
    username = mkOpt str "david" "The username of the main user";
    fullname = mkOpt str "David Schaller" "The full name of the main user";
  };

  config = {
    users.users.${cfg.username} = {
      isNormalUser = true;
      description = cfg.fullname;
      extraGroups =
        let
          ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
        in
        [
          "wheel" # for sudo
          "video" # for light (backlight control)
        ] ++ ifTheyExist [
          "deluge"
          "git"
          "libvirtd"
          "networkmanager"
          "wireshark"
        ];

      packages = config.users.users.root.packages;

      openssh.authorizedKeys.keyFiles = [ ];
    };

    snowfallorg.users.${cfg.username}.home.config = {
      home.file.".face".source = face;
    };

    nix.settings.trusted-users = [ cfg.username ];
    security.doas.extraRules.extraRules = [{
      users = [ cfg.username ];
      noPass = true;
      keepEnv = true;
    }];
  };
}
