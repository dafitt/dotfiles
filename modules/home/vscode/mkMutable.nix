{ options, config, lib, pkgs, ... }:

# https://gist.github.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa
# This makes vscode settings/keybindings/tasks/snippets writable
with lib;
with lib.dafitt;
let
  # Path logic from:
  # https://github.com/nix-community/home-manager/blob/3876cc613ac3983078964ffb5a0c01d00028139e/modules/programs/vscode.nix
  cfg = config.programs.vscode;

  vscodePname = cfg.package.pname;

  configDir = {
    "vscode" = "Code";
    "vscode-insiders" = "Code - Insiders";
    "vscodium" = "VSCodium";
  }.${vscodePname};

  userDir =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support/${configDir}/User"
    else
      "${config.xdg.configHome}/${configDir}/User";

  configFilePath = "${userDir}/settings.json";
  tasksFilePath = "${userDir}/tasks.json";
  keybindingsFilePath = "${userDir}/keybindings.json";

  snippetDir = "${userDir}/snippets";

  pathsToMakeWritable = lib.flatten [
    (lib.optional (cfg.profile.default.userTasks != { }) tasksFilePath)
    (lib.optional (cfg.profile.default.userSettings != { }) configFilePath)
    (lib.optional (cfg.profile.default.keybindings != { }) keybindingsFilePath)
    (lib.optional (cfg.profile.default.globalSnippets != { }) "${snippetDir}/global.code-snippets")
    (lib.mapAttrsToList (language: _: "${snippetDir}/${language}.json") cfg.profile.default.languageSnippets)
  ];
in
{
  options.dafitt.vscode = with types; {
    mkMutable = mkBoolOpt config.dafitt.vscode.enable "Whether to make vscode settings mutable.";
  };

  config = mkIf config.dafitt.vscode.mkMutable {
    home.file = lib.genAttrs pathsToMakeWritable (_: {
      force = true;
      mutable = true;
    });
  };
}
