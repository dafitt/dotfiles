{ options, config, lib, pkgs, ... }:

with lib;
with lib.custom;
let
  cfg = config.custom.development.vscode;
in
{
  imports = [ ./mkMutable.nix ];

  options.custom.development.vscode = with types; {
    enable = mkBoolOpt config.custom.development.enableSuite "Enable vscode";
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
            # https://github.com/danth/stylix/blob/master/modules/vscode/template.mustache
            "editor.selectionHighlightBackground" = "#${config.lib.stylix.colors.base02}";
            "editor.wordHighlightBackground" = "#00000000";
            "editor.findMatchBackground" = "#${config.lib.stylix.colors.base0A}77";
            "searchEditor.findMatchBackground" = "#${config.lib.stylix.colors.base0A}77";

            #"button.background" = "#${config.lib.stylix.colors.base0D}";
            "button.foreground" = "#${config.lib.stylix.colors.base00}";
            #"button.secondaryBackground" = "#${config.lib.stylix.colors.base0E}";
            "button.secondaryForeground" = "#${config.lib.stylix.colors.base00}";
            "notification.buttonForeground" = "#${config.lib.stylix.colors.base00}";
            #"notification.buttonHoverBackground" = "#${config.lib.stylix.colors.base02}";
            "extensionButton.prominentForeground" = "#${config.lib.stylix.colors.base00}";
            #"extensionButton.prominentHoverBackground" = "#${config.lib.stylix.colors.base02}";

            "editorRuler.foreground" = "#${config.lib.stylix.colors.base01}";
            #"panel.border" = "#${config.lib.stylix.colors.base05}";

            "editorOverviewRuler.border" = "#00000000";
            "scrollbarSlider.activeBackground" = "#${config.lib.stylix.colors.base04}77";
            "scrollbarSlider.background" = "#${config.lib.stylix.colors.base03}33";
            "scrollbarSlider.hoverBackground" = "#${config.lib.stylix.colors.base03}77";


            # ---------
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
        "extensions.autoUpdate" = false;
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "git.enableCommitSigning" = false;
        "git.openRepositoryInParentFolders" = "never";
        "keyboard.dispatch" = "keyCode"; # use correct keycodes
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
        "hexeditor.columnWidth" = 32;
        "hexeditor.defaultEndianness" = "little";
        "hexeditor.inspectorType" = "aside";
        "hexeditor.showDecodedText" = true;
        "gitlens.showWelcomeOnInstall" = false;
        "gitlens.showWhatsNewAfterUpgrades" = false;
        "prettier.bracketSameLine" = true;
        "prettier.tabWidth" = 4;
        "redhat.telemetry.enabled" = false;
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
        # Insert Line above and below
        { "key" = "shift+enter"; "command" = "editor.action.insertLineBefore"; "when" = "editorTextFocus && !editorReadonly"; }
        { "key" = "ctrl+enter"; "command" = "editor.action.insertLineAfter"; "when" = "editorTextFocus && !editorReadonly"; }
        # Indent Line
        { "key" = "tab"; "command" = "editor.action.indentLines"; "when" = "editorTextFocus && !editorReadonly && !editorTabMovesFocus && !suggestWidgetHasFocusedSuggestion && !inSnippetMode && !atEndOfWord && !inlineSuggestionVisible"; }
        # Copy Line Down
        { "key" = "ctrl+alt+l"; "command" = "editor.action.copyLinesDownAction"; "when" = "editorTextFocus && !editorReadonly"; }
        # Toggle Comments
        { "key" = "ctrl+/"; "command" = "editor.action.commentLine"; "when" = "editorTextFocus && !editorReadonly"; }
        { "key" = "ctrl+shift+/"; "command" = "editor.action.blockComment"; "when" = "editorTextFocus && !editorReadonly"; }
        # Save All Files
        { "key" = "ctrl+shift+s"; "command" = "workbench.action.files.saveFiles"; }
        # File: Save As...
        { "key" = "ctrl+alt+s"; "command" = "workbench.action.files.saveAs"; }
        # Zen Mode
        { "key" = "ctrl+alt+z"; "command" = "workbench.action.toggleZenMode"; "when" = "!isAuxiliaryWindowFocusedContext"; }
        # VSCode settings: Change keybinding expression
        { "key" = "ctrl+e"; "command" = "keybindings.editor.defineWhenExpression"; "when" = "inKeybindings && keybindingFocus"; }
        # Code Runner: Run current File
        { "key" = "ctrl+e ctrl+e"; "command" = "code-runner.run"; "when" = "editorTextFocus && !editorReadonly && resourceExtname != .sql"; }
        # Copilot: Open Chat
        { "key" = "ctrl+shift+j"; "command" = "workbench.panel.chatSidebar.copilot"; }
        # Unsets
        # Unset Ctrl-L for line selection
        { "key" = "ctrl+l"; "command" = "-workbench.action.chat.clear"; }
        # Unset Ctrl-Shift-Z for redo
        { "key" = "ctrl+shift+z"; "command" = "-extension.decrementPriority"; }
        # Unset todo-txt
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
        # general
        #christian-kohler.path-intellisense
        #cschlosser.doxdocgen
        codezombiech.gitignore # gitignore
        dotjoshjohnson.xml # xml
        foxundermoon.shell-format # shell
        james-yu.latex-workshop # latex
        jock.svg # svg
        redhat.vscode-yaml # yaml
        tamasfe.even-better-toml # toml
        #tomoki1207.pdf # pdf
        # c/c++
        #ms-vscode.cpptools
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb
        twxs.cmake
        # nix
        bbenoist.nix
        jnoortheen.nix-ide
        # php
        bmewburn.vscode-intelephense-client
        # markdown
        yzhang.markdown-all-in-one
        # html
        formulahendry.auto-close-tag
        formulahendry.auto-rename-tag
        gencer.html-slim-scss-css-class-completion
        # python
        ms-python.python

        # Features / Advancements #
        esbenp.prettier-vscode
        eamodio.gitlens
        #chouzz.vscode-better-align
        #donjayamanne.githistory # git
        #mhutchie.git-graph # git
        #nonoroazoro.syncing
        adpyke.codesnap
        formulahendry.code-runner
        github.copilot
        github.copilot-chat
        github.vscode-pull-request-github
        gruntfuggly.todo-tree
        kamikillerto.vscode-colorize
        ibm.output-colorizer
        ms-vscode.hexeditor
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # Advancements
        {
          name = "better-comments";
          publisher = "aaron-bond";
          version = "3.0.2";
          sha256 = "15w1ixvp6vn9ng6mmcmv9ch0ngx8m85i1yabxdfn6zx3ypq802c5";
        }
        #{
        #  name = "better-dockerfile-syntax";
        #  publisher = "jeff-hykin";
        #  version = "1.0.2";
        #  #sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #}
        {
          name = "better-jsonc-syntax";
          publisher = "jeff-hykin";
          version = "1.0.3";
          sha256 = "KXSP65TG8OGXSJv1FTl+gBaexg6VWysQ5mHIhLf9PgM=";
        }
        {
          name = "better-shellscript-syntax";
          publisher = "jeff-hykin";
          version = "1.6.2";
          sha256 = "008lhsww28c6qzsih662iakzz7py34rw36445icw5ywvzv8xpb18";
        }
        {
          name = "better-folding";
          publisher = "MohammadBaqer";
          version = "0.5.1";
          sha256 = "vEZi+rBT8dxhi+sIPSXWpUiWmE29deWzKj7uN7T+4is=";
        }
        {
          name = "bracket-select2";
          publisher = "jhasse";
          version = "2.1.1";
          sha256 = "sha256-1t5y9C6793l7YPihmNFqlEjo//MpQqOwnrKhjGecn90=";
        }
        {
          name = "auto-add-brackets";
          publisher = "aliariff";
          version = "0.12.2";
          sha256 = "sha256-DH1NfneJTMC7BmOP4IiUG8J7BQtwOj4/k5Qn62DkZ7Q=";
        }
        {
          name = "bracket-padder";
          publisher = "viablelab";
          version = "0.3.0";
          sha256 = "sha256-5DfEaG8vRYcpebeBcWidaySaOgMdrDT8DiS1TmpetKg=";
        }
        {
          name = "vscode-filesystemtoolbox";
          publisher = "carlocardella";
          version = "1.5.0";
          sha256 = "0wfbqglpfh4afkp6ykibzhznf6s3is23k5jwiipfr4jcmjki5kbc";
        }
        {
          name = "vscode-stylelint";
          publisher = "stylelint";
          version = "1.3.0";
          sha256 = "1q1idvpqnzlp186kymq2h407hqnhzngxs8n414p13j0svpcrm016";
        }
        ## Language support
        {
          name = "fix-all-json";
          publisher = "zardoy";
          version = "0.1.5";
          sha256 = "nkp5wdUPy+lUmc4Yg3b+NNosQgCPr6/sVad+j4Ln7Uo=";
        }
        {
          name = "haltarys-shellman";
          publisher = "Haltarys";
          version = "5.7.1";
          sha256 = "0gw0nd5yhq7d08mf7k78zz8xaj23qlirip3amx2jmqjav1fbz46m";
        }
        {
          name = "latex-utilities";
          publisher = "tecosaur";
          version = "0.4.10";
          sha256 = "sha256-tNf4sTsae+NKB7QZ5PQOXI6T14eEH0YIK/LhgWq6QHA=";
        }
        {
          name = "latexindent";
          publisher = "lenagain";
          version = "0.0.1";
          sha256 = "sha256-/gH64YE7bVqYdGI3GTaOYhLHIA+ndqqDEGl72jqratI=";
        }
        {
          name = "linux-desktop-file";
          publisher = "nico-castell";
          version = "0.0.21";
          sha256 = "0d2pfby72qczljzw1dk2rsqkqharl2sbq3g31zylz0rx73cvxb72";
        }
        {
          name = "todotxt-mode";
          publisher = "davraamides";
          version = "1.4.32";
          sha256 = "sha256-HICvHLL9mCKyQqEZYfOb+q8tmSS4NzxkuLle8MdEA2Y=";
        }
        {
          name = "vscode-sql-formatter";
          publisher = "adpyke";
          version = "1.4.4";
          sha256 = "sha256-g4oqB0zV7jB7PeA/d2e8jKfHh+Ci+us0nK2agy1EBxs=";
        }
        #{
        #  name = "vscode-groovy-lint";
        #  publisher = "nicolasvuillamy";
        #  version = "2.0.0";
        #  #sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #}
        {
          name = "vscode-css-peek";
          publisher = "pranaygp";
          version = "4.4.1";
          sha256 = "189134apvp0xj8s0bwbj9iyyzns395l7v0mlda5x0ny86zs8jzhr";
        }
        #{
        #  name = "bash-debug";
        #  publisher = "rogalmic";
        #  version = "0.3.9";
        #  #sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #}
        #{
        #  name = "jenkins-jack";
        #  publisher = "tabeyti";
        #  version = "1.2.1";
        #  #sha256 = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
        #}
        {
          name = "yuck";
          publisher = "eww-yuck";
          version = "0.0.3";
          sha256 = "DITgLedaO0Ifrttu+ZXkiaVA7Ua5RXc4jXQHPYLqrcM=";
        }
        ## Features
        #{
        #  name = "markdown-pdf";
        #  publisher = "yzane";
        #  version = "1.4.4";
        #  sha256 = "Tt1UF1i7bgWm/jRP6IG5UOQcfe5YOeCx6Hxs/bnkkgE=";
        #} # Cant download chromium: Read only filesystem!
        {
          name = "vscode-status-bar-format-toggle";
          publisher = "tombonnike";
          version = "3.1.1";
          sha256 = "mZymHbdJ7HD6acBPomwxKyatDfkDPAA0PaZpPU+nViQ=";
        }
      ];
    };

    wayland.windowManager.hyprland.settings = {
      exec-once = [ "[workspace 4 silent] ${config.programs.vscode.package}/bin/code" ];
    };
  };
}
