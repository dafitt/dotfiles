{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.Development.git;
in
{
  options.dafitt.Development.git = with types; {
    enable = mkBoolOpt config.dafitt.Development.enableSuite "Enable git.";
  };

  config = mkIf cfg.enable {
    # Distributed version control system
    # https://git-scm.com/
    programs.git = {
      enable = true;
      userName = "dafitt";
      userEmail = "dafitt@posteo.me";

      extraConfig = {
        init = { defaultBranch = "main"; };
        pull = { rebase = true; };
        core = { whitespace = "trailing-space,space-before-tab"; };
      };
    };
  };
}
