{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

# https://gist.github.com/piousdeer/b29c272eaeba398b864da6abf6cb5daa
# This makes vscode settings/keybindings/tasks/snippets writable
with lib;
let
  # Path logic from:
  # https://github.com/nix-community/home-manager/blob/3876cc613ac3983078964ffb5a0c01d00028139e/modules/programs/vscode.nix
  configDirName =
    {
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
    }
    .${config.programs.vscode.package.pname};

  configUserDirPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support/${configDirName}/User"
    else
      "${config.xdg.configHome}/${configDirName}/User";

  snippetDir = "${configUserDirPath}/snippets";
  pathsToMakeWritable = lib.flatten (
    with config.programs.vscode.profiles.default;
    [
      (lib.optional (userSettings != { }) "${configUserDirPath}/settings.json")
      (lib.optional (keybindings != [ ]) "${configUserDirPath}/keybindings.json")
      (lib.optional (userTasks != { }) "${configUserDirPath}/tasks.json")
      (lib.optional (globalSnippets != { }) "${snippetDir}/global.code-snippets")
      (lib.mapAttrsToList (language: _: "${snippetDir}/${language}.json") languageSnippets)
    ]
  );
in
{
  imports = with inputs; [
    self.homeModules.home-manager-mutableFiles
  ];

  options.dafitt.vscode = with types; {
    mkMutable = mkOption {
      type = bool;
      default = true;
      description = "Whether to make vscode settings mutable.";
    };
  };

  config = mkIf config.dafitt.vscode.mkMutable {
    home.file = lib.genAttrs pathsToMakeWritable (_: {
      force = true;
      mutable = true;
    });
  };
}
