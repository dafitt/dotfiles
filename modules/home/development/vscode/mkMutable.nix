{ options, config, lib, pkgs, ... }:

# This makes vscode settings/keybindings/tasks/snippets writable
# from <https://gist.github.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa>
with lib;
with lib.custom;
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
    (lib.optional (cfg.userTasks != { }) tasksFilePath)
    (lib.optional (cfg.userSettings != { }) configFilePath)
    (lib.optional (cfg.keybindings != { }) keybindingsFilePath)
    (lib.optional (cfg.globalSnippets != { }) "${snippetDir}/global.code-snippets")
    (lib.mapAttrsToList (language: _: "${snippetDir}/${language}.json") cfg.languageSnippets)
  ];
in
{
  options.custom.development.vscode = with types; {
    mkMutable = mkBoolOpt config.custom.development.vscode.enable "Make vscode directory";
  };

  config = mkIf config.custom.development.vscode.mkMutable {
    home.file = lib.genAttrs pathsToMakeWritable (_: {
      force = true;
      mutable = true;
    });
  };
}
