{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.shells.fish;

  isDefault = config.dafitt.shells.default == "fish";
in
{
  options.dafitt.shells.fish = with types; {
    enable = mkBoolOpt isDefault "Enable fish shell.";
  };

  config = mkMerge [
    (mkIf cfg.enable {
      programs.fish = {
        enable = true;
        # also use objects provided by other packages
        vendor = {
          completions.enable = true;
          config.enable = true;
          functions.enable = true;
        };
      };
    })
    (mkIf isDefault {
      # https://wiki.nixos.org/wiki/Fish#Setting_fish_as_your_shell
      programs.bash = {
        interactiveShellInit = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';
      };
    })
  ];
}
