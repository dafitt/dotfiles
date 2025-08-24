{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.stylix;
in
{
  imports = [ ./theme.nix ];

  options.dafitt.stylix = with types; {
    enable = mkEnableOption "stylix";
  };

  config = mkIf cfg.enable {
    # https://stylix.danth.me/options/nixos.html
    stylix = {
      enable = true;

      homeManagerIntegration.autoImport = false;
      # If true; stylix will complain about `home-manager.users.<user>.stylix.base16Scheme`
      # already declared. This is because we imported stylix.homeManagerModules.stylix
      # ourself in flake.nix in order to be able to build home-manager standalone. Without
      # `autoImport = true;` we have to declare stylix configuration for the user(s)
      # seperately. WORKAROUND for users to still follow the system theme: see `theme.nix`
      # [NixOS Manual - Modularity](https://nixos.org/manual/nixos/stable/index.html#sec-modularity)

      #TODO upstream: allow `homeManagerIntegration.autoImport = true;` when building with stylix.homeManagerModules.stylix to allow users to follow the system theme
    };
  };
}
