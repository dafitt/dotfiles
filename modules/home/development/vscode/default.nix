{ options, config, lib, pkgs, ... }:

with lib;
with lib.dafitt;
let
  cfg = config.dafitt.development.vscode;
in
{
  imports = [ ./mkMutable.nix ];

  options.dafitt.development.vscode = with types; {
    enable = mkBoolOpt config.dafitt.development.enableSuite "Enable vscode";
    autostart = mkBoolOpt true "Start vscode on login";
    defaultApplication = mkBoolOpt true "Set vscode as the default application for its mimetypes";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      xdg-utils # xdg-open to open hyperlinks
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscode;
      userSettings = {

        # Window
        "window.autoDetectColorScheme" = true;
        "window.titleBarStyle" = "custom";
        "window.title" = "\${rootPath}/\${activeEditorShort}";
        "window.autoDetectHighContrast" = false;
        "window.zoomLevel" = 1;

        # Workbench
        "workbench.colorCustomizations" = {
          "[Stylix]" = {
            # TODO: 24.05 stylix changes

            # improve focus colors
            "focusBorder" = "#${config.lib.stylix.colors.base0D}";
            #"list.inactiveSelectionBackground" = "#${config.lib.stylix.colors.base00}";

            # improve widgets
            "input.background" = "#${config.lib.stylix.colors.base02}88";

            # improve input
            "selection.background" = "#${config.lib.stylix.colors.base0A}66";
            # improve input option colors
            "inputOption.activeBackground" = "#${config.lib.stylix.colors.base0A}";
            "inputOption.activeForeground" = "#${config.lib.stylix.colors.base00}";
            "inputOption.activeBorder" = "#00000000";

            # improve menu contrast
            "menu.border" = "#${config.lib.stylix.colors.base02}";
            "menu.separatorBackground" = "#${config.lib.stylix.colors.base02}";

            # improve active tab colors
            "tab.activeBorder" = "#${config.lib.stylix.colors.base0A}";
            "tab.activeBackground" = "#${config.lib.stylix.colors.base00}";
            "tab.inactiveForeground" = "#${config.lib.stylix.colors.base03}";
            "tab.hoverForeground" = "#${config.lib.stylix.colors.base05}";
            "tab.hoverBackground" = "#${config.lib.stylix.colors.base00}";
            # improve activity bar colors
            "activityBar.activeBackground" = "#${config.lib.stylix.colors.base00}";
            #"activityBar.activeBorder" = "#${config.lib.stylix.colors.base05}";
            #"activityBar.inactiveBorder" = "#${config.lib.stylix.colors.base03}";
            "activityBarBadge.foreground" = "#${config.lib.stylix.colors.base02}";

            # improve focus drop & hover opacity
            "editorGroup.dropBackground" = "#${config.lib.stylix.colors.base03}66";
            "list.dropBackground" = "#${config.lib.stylix.colors.base03}66";
            "list.hoverBackground" = "#${config.lib.stylix.colors.base03}66";
            "editorStickyScrollHover.background" = "#${config.lib.stylix.colors.base03}66";

            # improve selection & find match colors
            "editor.findMatchBackground" = "#${config.lib.stylix.colors.base0A}66";
            "editor.findMatchBorder" = "#${config.lib.stylix.colors.base0A}";
            "editorOverviewRuler.findMatchForeground" = "#${config.lib.stylix.colors.base0A}";
            "editor.findMatchHighlightBackground" = "#${config.lib.stylix.colors.base0A}66";
            #"editor.findMatchHighlightBorder" = "#${config.lib.stylix.colors.base0A}66";
            "editor.selectionBackground" = "#${config.lib.stylix.colors.base0A}66";
            "editor.wordHighlightBackground" = "#${config.lib.stylix.colors.base0A}18";
            "editorOverviewRuler.wordHighlightForeground" = "#${config.lib.stylix.colors.base0A}4C";
            "editor.inactiveSelectionBackground" = "#${config.lib.stylix.colors.base0A}18";
            "editor.selectionHighlightBorder" = "#${config.lib.stylix.colors.base0A}18";
            "editor.selectionHighlightBackground" = "#${config.lib.stylix.colors.base0A}18";
            "editorOverviewRuler.selectionHighlightForeground" = "#${config.lib.stylix.colors.base0A}88";
            "editorOverviewRuler.rangeHighlightForeground" = "#${config.lib.stylix.colors.base0A}";

            # improve git colors in overview ruler
            "editorOverviewRuler.modifiedForeground" = "#${config.lib.stylix.colors.base0E}66";
            "editorOverviewRuler.addedForeground" = "#${config.lib.stylix.colors.base0B}66";
            "editorOverviewRuler.deletedForeground" = "#${config.lib.stylix.colors.base08}66";

            # improve workspace backgrounds
            "editorStickyScroll.background" = "#${config.lib.stylix.colors.base01}";
            "panel.background" = "#${config.lib.stylix.colors.base01}";
            "panel.border" = "#${config.lib.stylix.colors.base01}";
            #"terminal.background" = "#${config.lib.stylix.colors.base01}";

            "keybindingLabel.background" = "#${config.lib.stylix.colors.base03}";
            "keybindingLabel.bottomBorder" = "#${config.lib.stylix.colors.base03}";
            "keybindingLabel.border" = "#${config.lib.stylix.colors.base03}";

            # better git colors
            #"gitDecoration.modifiedResourceForeground" = "#${config.lib.stylix.colors.base09}";
            #"editorGutter.modifiedBackground" = "#${config.lib.stylix.colors.base09}";
            #"minimapGutter.modifiedBackground" = "#${config.lib.stylix.colors.base09}";
            #"editorOverviewRuler.modifiedForeground" = "#${config.lib.stylix.colors.base09}";


            # ---------
            "widget.shadow" = "#00000000";
            "editorWidget.background" = "#${config.lib.stylix.colors.base00}";
            "listFilterWidget.background" = "#${config.lib.stylix.colors.base00}";
            "widget.border" = "#${config.lib.stylix.colors.base02}";
            "editorWidget.resizeBorder" = "#${config.lib.stylix.colors.base0D}";
            "editorOverviewRuler.border" = "#00000000";
            "scrollbarSlider.activeBackground" = "#${config.lib.stylix.colors.base04}88";
            "scrollbarSlider.background" = "#${config.lib.stylix.colors.base03}33";
            "scrollbarSlider.hoverBackground" = "#${config.lib.stylix.colors.base03}88";
            "button.foreground" = "#${config.lib.stylix.colors.base00}";
            "button.secondaryForeground" = "#${config.lib.stylix.colors.base00}";
            "notification.buttonForeground" = "#${config.lib.stylix.colors.base00}";
            "extensionButton.prominentForeground" = "#${config.lib.stylix.colors.base00}";
            "editorRuler.foreground" = "#${config.lib.stylix.colors.base02}";
            "tab.border" = "#00000000";
            "statusBar.background" = "#${config.lib.stylix.colors.base01}";
            "statusBar.foreground" = "#${config.lib.stylix.colors.base05}";
            "statusBar.debuggingBackground" = "#${config.lib.stylix.colors.base09}";
            "statusBar.debuggingForeground" = "#${config.lib.stylix.colors.base00}";
            "statusBar.noFolderBackground" = "#${config.lib.stylix.colors.base01}";
            "statusBar.noFolderForeground" = "#${config.lib.stylix.colors.base05}";
            "statusBarItem.activeBackground" = "#${config.lib.stylix.colors.base03}";
            "statusBarItem.hoverBackground" = "#${config.lib.stylix.colors.base03}";
            "statusBarItem.prominentForeground" = "#${config.lib.stylix.colors.base00}";
            "statusBarItem.prominentBackground" = "#${config.lib.stylix.colors.base0E}";
            "statusBarItem.prominentHoverBackground" = "#${config.lib.stylix.colors.base03}";
            "statusBarItem.remoteBackground" = "#${config.lib.stylix.colors.base0B}";
            "statusBarItem.remoteForeground" = "#${config.lib.stylix.colors.base00}";
            "statusBarItem.errorBackground" = "#${config.lib.stylix.colors.base08}";
            "statusBarItem.errorForeground" = "#${config.lib.stylix.colors.base00}";
            "statusBarItem.warningBackground" = "#${config.lib.stylix.colors.base0A}";
            "statusBarItem.warningForeground" = "#${config.lib.stylix.colors.base00}";
            "editorInlayHint.foreground" = "#${config.lib.stylix.colors.base03}";
            "editorInlayHint.typeBackground" = "#${config.lib.stylix.colors.base01}";
            "editorInlayHint.typeForeground" = "#${config.lib.stylix.colors.base03}";
            "editorInlayHint.parameterBackground" = "#${config.lib.stylix.colors.base01}";
            "editorInlayHint.parameterForeground" = "#${config.lib.stylix.colors.base03}";
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
        "editor.stickyScroll.enabled" = true;
        "editor.stickyScroll.defaultModel" = "indentationModel";
        "editor.wordWrap" = "off";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;

        # Language settings
        "[c]" = {
          "editor.defaultFormatter" = "llvm-vs-code-extensions.vscode-clangd";
          "editor.tabSize" = 8;
        };
        "[ignore]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[json]" = {
          "editor.tabSize" = 2;
        };
        "[jsonc]" = {
          "editor.tabSize" = 2;
        };
        "[latex]" = {
          "editor.defaultFormatter" = "lenagain.latexindent";
        };
        "[markdown]" = { };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.insertSpaces" = true;
          "editor.tabSize" = 2;
        };
        "[properties]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[php]" = {
          "editor.defaultFormatter" = "bmewburn.vscode-intelephense-client";
        };
        "[shellscript]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[sql]" = {
          #"editor.defaultFormatter" = "adpyke.vscode-sql-formatter";
          #"editor.foldingStrategy" = "indentation";
          #"editor.foldingHighlight" = false;
          #"editor.foldingImportsByDefault" = true;
        };
        "[yaml]" = {
          "editor.defaultFormatter" = "redhat.vscode-yaml";
          "editor.tabSize" = 2;
        };
        "[yuck]" = {
          "editor.tabSize" = 2;
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
        "betterAlign.alignAfterTypeEnter" = true;
        "betterFolding.excludedLanguages" = [ "sql" ];
        "betterFolding.showFoldedBodyLinesCount" = false;
        "code-runner.runInTerminal" = true;
        "codesnap.containerPadding" = "0em";
        "codesnap.roundedCorners" = false;
        "codesnap.showWindowControls" = false;
        "codesnap.transparentBackground" = true;
        "colorize.decoration_type" = "underline";
        "gitlens.showWelcomeOnInstall" = false;
        "gitlens.showWhatsNewAfterUpgrades" = false;
        "gitlens.telemetry.enabled" = false;
        "hexeditor.columnWidth" = 32;
        "hexeditor.defaultEndianness" = "little";
        "hexeditor.inspectorType" = "aside";
        "hexeditor.showDecodedText" = true;
        "intelephense.telemetry.enabled" = false;
        "prettier.bracketSameLine" = true;
        "prettier.tabWidth" = 4;
        "redhat.telemetry.enabled" = false;
        "markdown-preview-github-styles.colorTheme" = "dark";
        "markdown-preview-enhanced.previewTheme" = "atom-dark.css";
        # Todo-tree
        "todo-tree.general.tags" = [
          "FIXME"
          "TODO"
          "REFACTOR"
          "???"
          "[ ]"
        ];
        "todo-tree.highlights.defaultHighlight" = {
          "icon" = "alert";
          "type" = "tag";
          "foreground" = "#${config.lib.stylix.colors.base01}";
          "background" = "#${config.lib.stylix.colors.base05}";
          "iconColour" = "#${config.lib.stylix.colors.base05}";
          "opacity" = 90;
        };
        "todo-tree.highlights.customHighlight" = {
          "FIXME" = {
            # FIXME test
            "icon" = "flame";
            "foreground" = "#${config.lib.stylix.colors.base00}";
            "background" = "#${config.lib.stylix.colors.base08}";
            "iconColour" = "#${config.lib.stylix.colors.base08}";
          };
          "TODO" = {
            # TODO test
            "icon" = "code";
            "foreground" = "#${config.lib.stylix.colors.base00}";
            "background" = "#${config.lib.stylix.colors.base09}";
            "iconColour" = "#${config.lib.stylix.colors.base09}";
          };
          "???" = {
            # ??? test
            "icon" = "question";
            "foreground" = "#${config.lib.stylix.colors.base00}";
            "background" = "#${config.lib.stylix.colors.base0D}";
            "iconColour" = "#${config.lib.stylix.colors.base0D}";
          };
          "REFACTOR" = {
            # REFACTOR test
            "icon" = "tools";
            "foreground" = "#${config.lib.stylix.colors.base00}";
            "background" = "#${config.lib.stylix.colors.base0E}";
            "iconColour" = "#${config.lib.stylix.colors.base0E}";
          };
          "[ ]" = {
            # [ ]
            "icon" = "tasklist";
          };
        };
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
            "color" = "#${config.lib.stylix.colors.base06}";
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
        # file: save as...
        { "key" = "ctrl+alt+s"; "command" = "workbench.action.files.saveAs"; }
        # zen mode
        { "key" = "ctrl+alt+z"; "command" = "workbench.action.toggleZenMode"; "when" = "!isAuxiliaryWindowFocusedContext"; }
        # vscode settings: change keybinding expression
        { "key" = "ctrl+e"; "command" = "keybindings.editor.defineWhenExpression"; "when" = "inKeybindings && keybindingFocus"; }
        # code runner: run current file
        { "key" = "ctrl+e ctrl+e"; "command" = "code-runner.run"; "when" = "editorTextFocus && !editorReadonly && resourceExtname != .sql"; }
        # copilot: open chat
        { "key" = "ctrl+shift+j"; "command" = "workbench.panel.chatSidebar.copilot"; }
        # unsets
        # unset ctrl-l for line selection
        { "key" = "ctrl+l"; "command" = "-workbench.action.chat.clear"; }
        # unset ctrl-shift-z for redo
        { "key" = "ctrl+shift+z"; "command" = "-extension.decrementPriority"; }
        # unset todo-txt
        { "key" = "ctrl+shift+a"; "command" = "-extension.incrementPriority"; }
      ];

      globalSnippets = {
        fixme = {
          body = [
            "$LINE_COMMENT FIXME= $0"
          ];
          description = "Insert a FIXME remark";
          prefix = [
            "fixme"
          ];
        };
      };

      languageSnippets = {
        html = {
          "PHP tag" = {
            "prefix" = [ "php" "?" ];
            "body" = "<?php\n$0\n?>";
          };
        };
      };

      extensions = with pkgs.vscode-extensions; [
        # Language Support #
        # binary
        ms-vscode.hexeditor
        # c/c++
        llvm-vs-code-extensions.vscode-clangd
        ms-vscode.makefile-tools
        vadimcn.vscode-lldb
        twxs.cmake
        # gitignore
        codezombiech.gitignore
        # html
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        gencer.html-slim-scss-css-class-completion
        # latex
        james-yu.latex-workshop
        # markdown
        yzhang.markdown-all-in-one
        # makefile
        ms-vscode.makefile-tools
        # nix
        jnoortheen.nix-ide
        # pdf
        #tomoki1207.pdf
        # php
        bmewburn.vscode-intelephense-client
        # pyhton
        ms-python.python
        # shell
        foxundermoon.shell-format
        # svg
        jock.svg # svg
        # toml
        tamasfe.even-better-toml
        # yaml
        redhat.vscode-yaml
        # xml
        dotjoshjohnson.xml

        # Features / Advancements #
        adpyke.codesnap
        eamodio.gitlens
        esbenp.prettier-vscode
        formulahendry.code-runner
        github.copilot
        github.copilot-chat
        github.vscode-pull-request-github
        gruntfuggly.todo-tree
        ibm.output-colorizer
        kamikillerto.vscode-colorize
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # TODO: cschlosser.doxdocgen

        # Language support #
        # css
        { name = "vscode-css-peek"; publisher = "pranaygp"; version = "4.4.1"; sha256 = "189134apvp0xj8s0bwbj9iyyzns395l7v0mlda5x0ny86zs8jzhr"; }
        # desktop files
        { name = "linux-desktop-file"; publisher = "nico-castell"; version = "0.0.21"; sha256 = "0d2pfby72qczljzw1dk2rsqkqharl2sbq3g31zylz0rx73cvxb72"; }
        # json
        { name = "fix-all-json"; publisher = "zardoy"; version = "0.1.5"; sha256 = "nkp5wdUPy+lUmc4Yg3b+NNosQgCPr6/sVad+j4Ln7Uo="; }
        # latex
        { name = "latex-utilities"; publisher = "tecosaur"; version = "0.4.10"; sha256 = "sha256-tNf4sTsae+NKB7QZ5PQOXI6T14eEH0YIK/LhgWq6QHA="; }
        { name = "latexindent"; publisher = "lenagain"; version = "0.0.1"; sha256 = "sha256-/gH64YE7bVqYdGI3GTaOYhLHIA+ndqqDEGl72jqratI="; }
        # markdown
        { name = "markdown-preview-github-styles"; publisher = "bierner"; version = "2.0.4"; sha256 = "sha256-jJulxvjMNsqQqmsb5szQIAUuLWuHw824Caa0KArjUVw="; }
        # shell
        { name = "haltarys-shellman"; publisher = "Haltarys"; version = "5.7.1"; sha256 = "0gw0nd5yhq7d08mf7k78zz8xaj23qlirip3amx2jmqjav1fbz46m"; }
        # sql
        { name = "vscode-sql-formatter"; publisher = "adpyke"; version = "1.4.4"; sha256 = "sha256-g4oqB0zV7jB7PeA/d2e8jKfHh+Ci+us0nK2agy1EBxs="; }
        # todo-txt
        { name = "todotxt-mode"; publisher = "davraamides"; version = "1.4.32"; sha256 = "sha256-HICvHLL9mCKyQqEZYfOb+q8tmSS4NzxkuLle8MdEA2Y="; }

        #{ name = "vscode-groovy-lint"; publisher = "nicolasvuillamy"; version = "2.0.0"; sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
        #{ name = "bash-debug"; publisher = "rogalmic"; version = "0.3.9"; sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
        #{ name = "jenkins-jack"; publisher = "tabeyti"; version = "1.2.1"; sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }

        # Features / Advancements
        { name = "vscode-status-bar-format-toggle"; publisher = "tombonnike"; version = "3.1.1"; sha256 = "mZymHbdJ7HD6acBPomwxKyatDfkDPAA0PaZpPU+nViQ="; }
        { name = "better-comments"; publisher = "aaron-bond"; version = "3.0.2"; sha256 = "15w1ixvp6vn9ng6mmcmv9ch0ngx8m85i1yabxdfn6zx3ypq802c5"; }
        { name = "better-jsonc-syntax"; publisher = "jeff-hykin"; version = "1.0.3"; sha256 = "KXSP65TG8OGXSJv1FTl+gBaexg6VWysQ5mHIhLf9PgM="; }
        { name = "better-shellscript-syntax"; publisher = "jeff-hykin"; version = "1.6.2"; sha256 = "008lhsww28c6qzsih662iakzz7py34rw36445icw5ywvzv8xpb18"; }
        { name = "better-folding"; publisher = "MohammadBaqer"; version = "0.5.1"; sha256 = "vEZi+rBT8dxhi+sIPSXWpUiWmE29deWzKj7uN7T+4is="; }
        { name = "bracket-select2"; publisher = "jhasse"; version = "2.1.1"; sha256 = "sha256-1t5y9C6793l7YPihmNFqlEjo//MpQqOwnrKhjGecn90="; }
        { name = "auto-add-brackets"; publisher = "aliariff"; version = "0.12.2"; sha256 = "sha256-DH1NfneJTMC7BmOP4IiUG8J7BQtwOj4/k5Qn62DkZ7Q="; }
        { name = "bracket-padder"; publisher = "viablelab"; version = "0.3.0"; sha256 = "sha256-5DfEaG8vRYcpebeBcWidaySaOgMdrDT8DiS1TmpetKg="; }
        { name = "vscode-filesystemtoolbox"; publisher = "carlocardella"; version = "1.5.0"; sha256 = "0wfbqglpfh4afkp6ykibzhznf6s3is23k5jwiipfr4jcmjki5kbc"; }
        { name = "vscode-stylelint"; publisher = "stylelint"; version = "1.3.0"; sha256 = "1q1idvpqnzlp186kymq2h407hqnhzngxs8n414p13j0svpcrm016"; }
        #{ name = "better-dockerfile-syntax"; publisher = "jeff-hykin"; version = "1.0.2"; sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; }
      ];
    };

    xdg.mimeApps.defaultApplications = mkIf cfg.defaultApplication (listToAttrs (map (mimeType: { name = mimeType; value = [ "code.desktop" ]; }) [
      "application/x-shellscript"
      "text/english"
      "text/html"
      "text/x-c"
      "text/x-c++"
      "text/x-c++hdr"
      "text/x-c++src"
      "text/x-chdr"
      "text/x-csrc"
      "text/x-java"
      "text/x-makefile"
      "text/x-moc"
      "text/x-pascal"
      "text/x-tcl"
      "text/x-tex"
      "text/xml"
    ]));

    wayland.windowManager.hyprland.settings = {
      bind = [ "SUPER_ALT, G, exec, ${getExe config.programs.vscode.package}" ];
      exec-once = mkIf cfg.autostart [ "[workspace 4 silent] ${getExe config.programs.vscode.package}" ];
    };
  };
}
