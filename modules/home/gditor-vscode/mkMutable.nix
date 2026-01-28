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
  cfg = config.programs.vscode;

  # Path logic from:
  # https://github.com/nix-community/home-manager/blob/eec72f127831326b042d1f35003767a4ab6a9516/modules/programs/vscode/default.nix#L51
  configDirName =
    {
      "vscode" = "Code";
      "vscode-insiders" = "Code - Insiders";
      "vscodium" = "VSCodium";
      "openvscode-server" = "OpenVSCode Server";
      "windsurf" = "Windsurf";
      "cursor" = "Cursor";
    }
    .${cfg.package.pname};

  configUserDirPath =
    if pkgs.stdenv.hostPlatform.isDarwin then
      "Library/Application Support/${configDirName}/User"
    else
      "${config.xdg.configHome}/${configDirName}/User";

  configFilePath =
    name:
    "${configUserDirPath}/${lib.optionalString (name != "default") "profiles/${name}/"}settings.json";
  tasksFilePath =
    name:
    "${configUserDirPath}/${lib.optionalString (name != "default") "profiles/${name}/"}tasks.json";
  keybindingsFilePath =
    name:
    "${configUserDirPath}/${
      lib.optionalString (name != "default") "profiles/${name}/"
    }keybindings.json";
  snippetDirPath =
    name: "${configUserDirPath}/${lib.optionalString (name != "default") "profiles/${name}/"}snippets";

  pathsToMakeWritable = lib.flatten [
    (lib.mapAttrsToList (n: v: [
      (lib.optional (
        v.userSettings != { } || v.enableUpdateCheck != null || v.enableExtensionUpdateCheck != null
      ) (configFilePath n))
      (lib.optional (v.userTasks != { }) (tasksFilePath n))
      (lib.optional (v.keybindings != [ ]) (keybindingsFilePath n))
      (lib.optional (v.globalSnippets != { }) "${snippetDirPath n}/global.code-snippets")
      (lib.mapAttrsToList (language: _: "${snippetDirPath n}/${language}.json") v.languageSnippets)
    ]) cfg.profiles)
  ];
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
