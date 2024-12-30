{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.vscode;
in
{
  imports = [ ./mkMutable.nix ];

  options.dafitt.vscode = with types; {
    enable = mkEnableOption "vscode";
    autostart = mkBoolOpt false "Start vscode on login";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-utils # xdg-open to open hyperlinks
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      userSettings = {

        # Window
        "window.titleBarStyle" = "custom";
        "window.title" = "\${rootPath}/\${activeEditorShort}";
        "window.autoDetectHighContrast" = false;
        "window.zoomLevel" = 1;

        # Workbench
        "workbench.colorCustomizations" = {
          "[Stylix]" = {
            # room for upstream adjustments
            # [vscode theming reference](https://code.visualstudio.com/api/references/theme-color)
            # [stylix](https://github.com/danth/stylix/blob/master/modules/vscode/template.mustache)
          };
        };
        "workbench.editor.defaultBinaryEditor" = "hexEditor.hexedit";
        "workbench.editor.showTabs" = "multiple";
        "workbench.startupEditor" = "none";
        "workbench.statusBar.visible" = true;
        "workbench.tree.expandMode" = "doubleClick";
        "workbench.tree.indent" = 24;

        # Editor
        "diffEditor.codeLens" = true;
        "diffEditor.diffAlgorithm" = "advanced";
        "diffEditor.experimental.collapseUnchangedRegions" = true;
        "diffEditor.experimental.useVersion2" = true;
        "diffEditor.hideUnchangedRegions.enabled" = true;
        "diffEditor.wordWrap" = "on";
        "editor.accessibilitySupport" = "off";
        "editor.comments.insertSpace" = false;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.fontLigatures" = true;
        "editor.formatOnSave" = true;
        "editor.guides.bracketPairs" = true;
        "editor.guides.bracketPairsHorizontal" = false;
        "editor.hover.delay" = 200;
        "editor.inlayHints.enabled" = "off";
        "editor.minimap.enabled" = false;
        "editor.minimap.renderCharacters" = false;
        "editor.minimap.scale" = 2;
        "editor.minimap.showSlider" = "always";
        "editor.minimap.side" = "left";
        "editor.minimap.size" = "fill";
        "editor.renderLineHighlightOnlyWhenFocus" = true;
        #"editor.rulers" = [ 80 ];
        "editor.scrollBeyondLastLine" = false;
        "editor.smoothScrolling" = true;
        "editor.stickyScroll.defaultModel" = "indentationModel";
        "editor.stickyScroll.enabled" = true;
        "editor.wordWrap" = "off";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;

        # Language settings
        "[ignore]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[json]" = {
          "editor.tabSize" = 2;
        };
        "[jsonc]" = {
          "editor.tabSize" = 2;
        };
        "[nft]" = {
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "omBratteng.nftables";
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.insertSpaces" = true;
          "editor.tabSize" = 2;
        };
        "[properties]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[shellscript]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };

        # Misellanious
        "breadcrumbs.enabled" = true;
        "explorer.confirmDelete" = false;
        "explorer.confirmDragAndDrop" = false;
        "extensions.autoCheckUpdates" = false;
        "extensions.autoUpdate" = false;
        "git.allowForcePush" = true;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = false;
        "git.openRepositoryInParentFolders" = "never";
        "keyboard.dispatch" = "keyCode"; # use correct keycodes
        "search.followSymlinks" = false;
        "search.quickOpen.includeHistory" = false;
        "search.quickOpen.history.filterSortOrder" = "recency";
        "search.searchOnType" = false;
        "security.workspace.trust.enabled" = false;
        "security.workspace.trust.untrustedFiles" = "open";
        "telemetry.telemetryLevel" = "off";
        "terminal.integrated.gpuAcceleration" = "on";
        "terminal.integrated.hideOnStartup" = "always";
        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "zenMode.fullScreen" = false;
        "zenMode.centerLayout" = false;

        # Extensions
        "betterFolding.excludedLanguages" = [ "sql" ];
        "betterFolding.showFoldedBodyLinesCount" = false;
        "code-runner.enableAppInsights" = false; # telemetry
        "code-runner.ignoreSelection" = true;
        "code-runner.runInTerminal" = true;
        "codeium.enableCodeLens" = false; # no inline action button popup
        "codesnap.containerPadding" = "0em";
        "codesnap.roundedCorners" = false;
        "codesnap.showWindowControls" = false;
        "codesnap.transparentBackground" = true;
        "colorize.decoration_type" = "underline";
        "githubPullRequests.remotes" = [ "origin" "upstream" "github" ];
        "gitlens.showWelcomeOnInstall" = false;
        "gitlens.showWhatsNewAfterUpgrades" = false;
        "gitlens.telemetry.enabled" = false;
        "intelephense.telemetry.enabled" = false;
        "markdown-preview-enhanced.previewTheme" = "atom-dark.css";
        "markdown-preview-github-styles.colorTheme" = "dark";
        "prettier.bracketSameLine" = true;
        "prettier.tabWidth" = 4;
        "redhat.telemetry.enabled" = false;
        "todo-tree.general.tags" = [
          "FIXME"
          "TODO"
          "TEST"
          "REFACTOR"
          "???"
          "[ ]"
        ];
        "todo-tree.highlights.defaultHighlight" = {
          "icon" = "alert";
          "type" = "tag";
          "foreground" = config.lib.stylix.colors.withHashtag.base01;
          "background" = config.lib.stylix.colors.withHashtag.base05;
          "iconColour" = config.lib.stylix.colors.withHashtag.base05;
          "opacity" = 90;
        };
        "todo-tree.highlights.customHighlight" = {
          "FIXME" = {
            # FIXME test
            "icon" = "flame";
            "foreground" = config.lib.stylix.colors.withHashtag.base00;
            "background" = config.lib.stylix.colors.withHashtag.base08;
            "iconColour" = config.lib.stylix.colors.withHashtag.base08;
          };
          "TODO" = {
            # TODO test
            "icon" = "code";
            "foreground" = config.lib.stylix.colors.withHashtag.base00;
            "background" = config.lib.stylix.colors.withHashtag.base09;
            "iconColour" = config.lib.stylix.colors.withHashtag.base09;
          };
          "TEST" = {
            # TEST test
            "icon" = "beaker";
            "foreground" = config.lib.stylix.colors.withHashtag.base00;
            "background" = config.lib.stylix.colors.withHashtag.base0A;
            "iconColour" = config.lib.stylix.colors.withHashtag.base0A;
          };
          "REFACTOR" = {
            # REFACTOR test
            "icon" = "tools";
            "foreground" = config.lib.stylix.colors.withHashtag.base00;
            "background" = config.lib.stylix.colors.withHashtag.base0C;
            "iconColour" = config.lib.stylix.colors.withHashtag.base0C;
          };
          "???" = {
            # ??? test
            "icon" = "question";
            "foreground" = config.lib.stylix.colors.withHashtag.base00;
            "background" = config.lib.stylix.colors.withHashtag.base0D;
            "iconColour" = config.lib.stylix.colors.withHashtag.base0D;
          };
          "[ ]" = {
            # [ ] test
            "icon" = "tasklist";
          };
        };
        "todo-tree.tree.labelFormat" = "\${after}";
        "todo-tree.tree.expanded" = true;
        "todo-tree.tree.tagsOnly" = true;
        "todo-tree.tree.groupedByTag" = true;
        "todo-tree.tree.hideIconsWhenGroupedByTag" = true;
        "todo-tree.regex.enableMultiLine" = true;
        "better-comments.tags" = [
          {
            #! test
            "tag" = "! ";
            "color" = "#FF2D00";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            #? test
            "tag" = "? ";
            "color" = "#3498DB";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = false;
            "italic" = false;
          }
          {
            #$ test
            "tag" = "$ ";
            #"color" = "#FF8C00";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = true;
            "italic" = false;
          }
          {
            #* test
            "tag" = "* ";
            "color" = "#98C379";
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = true;
            "italic" = false;
          }
          {
            #NOTE test
            "tag" = "NOTE ";
            "color" = config.lib.stylix.colors.withHashtag.base06;
            "strikethrough" = false;
            "underline" = false;
            "backgroundColor" = "transparent";
            "bold" = true;
            "italic" = false;
          }
        ];
      };

      keybindings = [
        # insert line above and below
        { "key" = "shift+enter"; "command" = "editor.action.insertLineBefore"; "when" = "editorTextFocus && !editorReadonly"; }
        { "key" = "ctrl+enter"; "command" = "editor.action.insertLineAfter"; "when" = "editorTextFocus && !editorReadonly"; }
        # sort lines
        { "key" = "ctrl+numpad3"; "command" = "editor.action.sortLinesAscending"; "when" = "editorTextFocus && !editorReadonly"; }
        { "key" = "ctrl+numpad9"; "command" = "editor.action.sortLinesDescending"; "when" = "editorTextFocus && !editorReadonly"; }
        # indent line
        { "key" = "tab"; "command" = "editor.action.indentLines"; "when" = "editorTextFocus && !editorReadonly && !editorTabMovesFocus && !suggestWidgetHasFocusedSuggestion && !inSnippetMode && !atEndOfWord && !inlineSuggestionVisible"; }
        # copy line down
        { "key" = "ctrl+alt+l"; "command" = "editor.action.copyLinesDownAction"; "when" = "editorTextFocus && !editorReadonly"; }
        # toggle comments
        { "key" = "ctrl+/"; "command" = "editor.action.commentLine"; "when" = "editorTextFocus && !editorReadonly"; }
        { "key" = "ctrl+shift+/"; "command" = "editor.action.blockComment"; "when" = "editorTextFocus && !editorReadonly"; }
        # save all files
        { "key" = "ctrl+shift+s"; "command" = "workbench.action.files.saveFiles"; }
        # file: save without formatting
        { "key" = "ctrl+shift+s"; "command" = "-workbench.action.files.saveAs"; }
        { "key" = "ctrl+shift+s"; "command" = "workbench.action.files.saveWithoutFormatting"; }
        # zen mode
        { "key" = "ctrl+alt+z"; "command" = "workbench.action.toggleZenMode"; "when" = "!isAuxiliaryWindowFocusedContext"; }
        # vscode settings: change keybinding expression
        { "key" = "ctrl+e"; "command" = "keybindings.editor.defineWhenExpression"; "when" = "inKeybindings && keybindingFocus"; }
        # code runner: run current file
        { "key" = "ctrl+e ctrl+e"; "command" = "code-runner.run"; "when" = "editorTextFocus && !editorReadonly && resourceExtname != .sql"; }
        # unsets
        # unset ctrl-l for line selection
        { "key" = "ctrl+l"; "command" = "-workbench.action.chat.clear"; }
        # unset ctrl-shift-z for redo
        { "key" = "ctrl+shift+z"; "command" = "-extension.decrementPriority"; }
        # unset todo-txt
        { "key" = "ctrl+shift+a"; "command" = "-extension.incrementPriority"; }
        # bracket-select: change bracket-select shortcut
        { "key" = "alt+a"; "command" = "-bracket-select.select"; }
        { "key" = "alt+z"; "command" = "-bracket-select.undo-select"; }
        { "key" = "ctrl+shift+a"; "command" = "-editor.action.blockComment"; }
        { "key" = "ctrl+shift+a"; "command" = "bracket-select.select-include"; "when" = "editorTextFocus"; }
      ];

      globalSnippets = {
        fixme = {
          body = [ "$LINE_COMMENT FIXME= $0" ];
          description = "Insert a FIXME remark.";
          prefix = [ "fixme" ];
        };
      };
      languageSnippets = { };

      extensions = with pkgs.vscode-extensions; [
        # https://search.nixos.org/packages#?type=packages&query=vscode-extensions.

        # Basic language Support #
        esbenp.prettier-vscode
        # gitignore
        codezombiech.gitignore
        # markdown
        yzhang.markdown-all-in-one
        # nix
        jnoortheen.nix-ide
        # pdf
        tomoki1207.pdf
        # shell
        foxundermoon.shell-format
        # svg
        jock.svg # svg
        # toml
        tamasfe.even-better-toml

        # Features / advancements #
        adpyke.codesnap
        formulahendry.code-runner
        github.vscode-pull-request-github
        gruntfuggly.todo-tree
        ibm.output-colorizer
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # https://marketplace.visualstudio.com/

        # Basic language support #
        { name = "vscode-assorted-languages"; publisher = "edwinkofler"; version = "0.31.1"; sha256 = "sha256-dC6l9vtuCpZM1GsrfDweZsVfsjop8wTqY+Ly5dw0Jwg="; }
        # desktop files
        { name = "linux-desktop-file"; publisher = "nico-castell"; version = "0.0.21"; sha256 = "0d2pfby72qczljzw1dk2rsqkqharl2sbq3g31zylz0rx73cvxb72"; }
        # json
        { name = "fix-all-json"; publisher = "zardoy"; version = "0.1.5"; sha256 = "nkp5wdUPy+lUmc4Yg3b+NNosQgCPr6/sVad+j4Ln7Uo="; }
        # markdown
        { name = "markdown-preview-github-styles"; publisher = "bierner"; version = "2.0.4"; sha256 = "sha256-jJulxvjMNsqQqmsb5szQIAUuLWuHw824Caa0KArjUVw="; }
        # nftables
        { name = "nftables"; publisher = "ombratteng"; version = "0.7.0"; sha256 = "sha256-nxs1C3MA+9dQylJs9RLQJ35SRZNanIWeYAaeVVzs2Fo="; }
        # shell
        { name = "haltarys-shellman"; publisher = "Haltarys"; version = "5.7.1"; sha256 = "0gw0nd5yhq7d08mf7k78zz8xaj23qlirip3amx2jmqjav1fbz46m"; }
        # todo-txt
        { name = "todotxt-mode"; publisher = "davraamides"; version = "1.4.32"; sha256 = "sha256-HICvHLL9mCKyQqEZYfOb+q8tmSS4NzxkuLle8MdEA2Y="; }

        # Features / advancements #
        { name = "auto-add-brackets"; publisher = "aliariff"; version = "0.12.2"; sha256 = "sha256-DH1NfneJTMC7BmOP4IiUG8J7BQtwOj4/k5Qn62DkZ7Q="; }
        { name = "bracket-select"; publisher = "chunsen"; version = "2.0.2"; sha256 = "sha256-2+42NJWAI0cz+RvmihO2v8J/ndAHvV3YqMExvnl46m4="; }
        { name = "better-comments"; publisher = "aaron-bond"; version = "3.0.2"; sha256 = "15w1ixvp6vn9ng6mmcmv9ch0ngx8m85i1yabxdfn6zx3ypq802c5"; }
        { name = "better-folding"; publisher = "MohammadBaqer"; version = "0.5.1"; sha256 = "vEZi+rBT8dxhi+sIPSXWpUiWmE29deWzKj7uN7T+4is="; }
        { name = "better-syntax"; publisher = "jeff-hykin"; version = "2.0.5"; sha256 = "sha256-D06msfuSOk+8hy2Amgn+d1aQoyjwotTqKzk1NS5AhnU="; }
        { name = "bracket-padder"; publisher = "viablelab"; version = "0.3.0"; sha256 = "sha256-5DfEaG8vRYcpebeBcWidaySaOgMdrDT8DiS1TmpetKg="; }
        { name = "vscode-filesystemtoolbox"; publisher = "carlocardella"; version = "1.5.0"; sha256 = "0wfbqglpfh4afkp6ykibzhznf6s3is23k5jwiipfr4jcmjki5kbc"; }
        { name = "vscode-status-bar-format-toggle"; publisher = "tombonnike"; version = "3.1.1"; sha256 = "mZymHbdJ7HD6acBPomwxKyatDfkDPAA0PaZpPU+nViQ="; }
        #{ name = "codeium"; publisher = "codeium"; version = "1.9.30"; sha256 = "sha256-0LkScGTeC269Tbf6JbdpkvEspqPwJlnh0v0tc+l1jHk="; }
      ];
    };

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, G, exec, ${getExe config.programs.vscode.package}" ];
      exec-once = mkIf cfg.autostart [ "[workspace 4 silent] ${getExe config.programs.vscode.package}" ];
    };

    # needs inputs.xdg-autostart.homeManagerModules.xdg-autostart
    xdg.autoStart.packages = mkIf cfg.autostart [ config.programs.vscode.package ];
  };
}
