{ config, pkgs, ... }: {

  # Open source code editor
  # https://github.com/VSCodium/vscodium
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    userSettings = {

      # Window
      "window.autoDetectColorScheme" = true;
      "window.titleBarStyle" = "custom";
      "window.title" = "\${rootPath}/\${activeEditorShort}";
      "window.autoDetectHighContrast" = false;
      "window.menuBarVisibility" = "compact";
      "window.zoomLevel" = 1;

      # Workbench
      "workbench.colorCustomizations" = {
        "[Stylix]" = {
          # <https://github.com/danth/stylix/blob/master/modules/vscode/template.mustache>
          "editor.selectionHighlightBackground" = "#${config.lib.stylix.colors.base04}EE";
          "editor.wordHighlightBackground" = "#${config.lib.stylix.colors.base01}00";
          "statusBar.background" = "#${config.lib.stylix.colors.base00}";
          "statusBar.noFolderBackground" = "#${config.lib.stylix.colors.base00}";
          "statusBar.noFolderForeground" = "#${config.lib.stylix.colors.base06}";
          "scrollbarSlider.activeBackground" = "#${config.lib.stylix.colors.base04}55";
          "scrollbarSlider.background" = "#${config.lib.stylix.colors.base03}55";
          "scrollbarSlider.hoverBackground" = "#${config.lib.stylix.colors.base04}99";
          "button.background" = "#${config.lib.stylix.colors.base0D}BB";
          "button.foreground" = "#${config.lib.stylix.colors.base06}";
          "button.secondaryBackground" = "#${config.lib.stylix.colors.base0E}BB";
          "button.secondaryForeground" = "#${config.lib.stylix.colors.base06}";
        };
      };
      "workbench.editor.showTabs" = true;
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
      #"editor.fontVariations" = false;
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
      "editor.rulers" = [ 80 ];
      "editor.scrollBeyondLastLine" = false;
      "editor.stickyScroll.enabled" = true;
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
      "[markdown]" = {
        "editor.formatOnSave" = false;
      };
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
        "[x]"
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
          "foreground" = "#${config.lib.stylix.colors.base01}";
          "background" = "#${config.lib.stylix.colors.base08}";
          "iconColour" = "#${config.lib.stylix.colors.base08}";
        };
        "TODO" = {
          # TODO test
          "icon" = "code";
          "foreground" = "#${config.lib.stylix.colors.base01}";
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
          "icon" = "issue-draft";
        };
        "[x]" = {
          # [x]
          "icon" = "issue-closed";
        };
      };
      "better-comments.tags" = [
        {
          #!! test
          "tag" = "!!";
          "color" = "#FF2D00";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = false;
          "italic" = false;
        }
        #{
        #  #?? test
        #  "tag" = "??";
        #  "color" = "#3498DB";
        #  "strikethrough" = false;
        #  "underline" = false;
        #  "backgroundColor" = "transparent";
        #  "bold" = false;
        #  "italic" = false;
        #}
        {
          #$$ test
          "tag" = "$$";
          #"color" = "#FF8C00";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = true;
          "italic" = false;
        }
        {
          #** test
          "tag" = "**";
          "color" = "#98C379";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = true;
          "italic" = false;
        }
      ];
    };

    keybindings = [
      {
        # Change keybinding expression
        "key" = "ctrl+e";
        "command" = "keybindings.editor.defineWhenExpression";
        "when" = "inKeybindings && keybindingFocus";
      }
      {
        # Insert Line Above
        "key" = "shift+enter";
        "command" = "editor.action.insertLineBefore";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        # Insert Line Below
        "key" = "ctrl+enter";
        "command" = "editor.action.insertLineAfter";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        # Indent Line
        "key" = "tab";
        "command" = "editor.action.indentLines";
        "when" = "editorTextFocus && !editorReadonly && !editorTabMovesFocus && !suggestWidgetHasFocusedSuggestion && !inSnippetMode && !atEndOfWord && !inlineSuggestionVisible";
      }
      {
        # Copy Line Down
        "key" = "ctrl+alt+l";
        "command" = "editor.action.copyLinesDownAction";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        # Toggle Line  Comment
        "key" = "ctrl+[Backslash]";
        "command" = "editor.action.commentLine";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        # Toggle Block Comment
        "key" = "ctrl+shift+[Backslash]";
        "command" = "editor.action.blockComment";
        "when" = "editorTextFocus && !editorReadonly";
      }

      {
        # Save All Files
        "key" = "ctrl+shift+s";
        "command" = "workbench.action.files.saveFiles";
      }
      {
        # File: Save As...
        "key" = "ctrl+alt+s";
        "command" = "workbench.action.files.saveAs";
      }
      {
        # Code Runner: Run current File
        "key" = "ctrl+e ctrl+e";
        "command" = "code-runner.run";
        "when" = "editorTextFocus && !editorReadonly && resourceExtname != .sql";
      }
      {
        # Copilot: Open Chat
        "key" = "ctrl+shift+j";
        "command" = "workbench.panel.chatSidebar.copilot";
      }
      {
        # Remove Ctrl-L for line selection
        "key" = "ctrl+l";
        "command" = "-workbench.action.chat.clear";
        "when" = "hasChatProvider && inChat";
      }
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
      bbenoist.nix # nix
      jnoortheen.nix-ide # nix
      #christian-kohler.path-intellisense
      #cschlosser.doxdocgen
      #ms-vscode.cpptools # c/c++
      llvm-vs-code-extensions.vscode-clangd # c/c++
      vadimcn.vscode-lldb # c/c++
      twxs.cmake # c/c++
      bmewburn.vscode-intelephense-client # php
      codezombiech.gitignore # gitignore
      yzhang.markdown-all-in-one # markdown
      dotjoshjohnson.xml # xml
      foxundermoon.shell-format # shell
      formulahendry.auto-close-tag # html
      formulahendry.auto-rename-tag # html
      gencer.html-slim-scss-css-class-completion # html
      james-yu.latex-workshop # latex
      jock.svg # svg
      ms-python.python # python
      redhat.vscode-yaml # yaml
      tamasfe.even-better-toml # toml
      #tomoki1207.pdf # pdf

      # Features / Advancements #
      esbenp.prettier-vscode
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
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace
      [
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
          name = "vscode-filesystemtoolbox";
          publisher = "carlocardella";
          version = "1.3.0";
          sha256 = "xj1I+7ATLSG32tm2cNhLwjpmdqPwPIsjmXrIzwbX7nE=";
        }
        {
          name = "vscode-stylelint";
          publisher = "stylelint";
          version = "1.2.4";
          sha256 = "krJ8vC+przrHL3PIQrW0hQhL6ntp71nhudP4LxdDIno=";
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
          name = "linux-desktop-file";
          publisher = "nico-castell";
          version = "0.0.21";
          sha256 = "0d2pfby72qczljzw1dk2rsqkqharl2sbq3g31zylz0rx73cvxb72";
        }
        {
          name = "vscode-sql-formatter";
          publisher = "adpyke";
          version = "1.4.4";
          sha256 = "sha256-g4oqB0zV7jB7PeA/d2e8jKfHh+Ci+us0nK2agy1EBxs=";
        }
        {
          name = "latex-utilities";
          publisher = "tecosaur";
          version = "0.4.10";
          sha256 = "sha256-tNf4sTsae+NKB7QZ5PQOXI6T14eEH0YIK/LhgWq6QHA=";
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
          name = "gitless";
          publisher = "maattdd";
          version = "11.7.2";
          sha256 = "05zbxi1f1jb53ijnxrj7ixm8xfsxmh8hlb6rwxsfc7gs3hs9k1xd";
        }
        {
          name = "vscode-status-bar-format-toggle";
          publisher = "tombonnike";
          version = "3.1.1";
          sha256 = "mZymHbdJ7HD6acBPomwxKyatDfkDPAA0PaZpPU+nViQ=";
        }
      ];
  };

  wayland.windowManager.hyprland.settings = {
    bind = [ "ALT SUPER, G, exec, ${pkgs.vscode}/bin/code" ];
  };

  home.packages = with pkgs; [
    nixpkgs-fmt # nix code formatter
    gcc # gnu c compiler
    clang-tools # clangd for c/c++
    texlive.combined.scheme-full # for latex-workshop
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # vscodium wayland
  };
}
