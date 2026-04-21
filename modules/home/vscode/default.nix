# reference: https://maksar.github.io/posts/code/2021-09-19-vscode/
{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions; [
        yzhang.markdown-all-in-one
        mkhl.direnv
        ecmel.vscode-html-css
        fill-labs.dependi
        ms-python.vscode-pylance
        ms-python.python
        ms-vscode-remote.vscode-remote-extensionpack
        ms-vscode-remote.remote-ssh
        ms-python.black-formatter
        rust-lang.rust-analyzer
        zguolee.tabler-icons
        vscode-icons-team.vscode-icons
        tal7aouy.icons
        tamasfe.even-better-toml
        kubukoz.nickel-syntax
        jnoortheen.nix-ide
        mesonbuild.mesonbuild
        haskell.haskell
        justusadam.language-haskell
        brettm12345.nixfmt-vscode
        bodil.blueprint-gtk
        ms-vscode.cpptools
        # relm4.relm4-snippets # todo: release to nixpkgs
      ];

      userSettings = {
        "editor" = {
          "fontSize" = 14;
          "formatOnSave" = true;
          # "defaultFormatter" = "ms-python.black-formatter";
          "accessibilitySupport" = "off";
        };
        "terminal" = {
          "integrated.fontSize" = 14;
          "integrated.suggest" = false;
          "integrated.inheritEnv" = false;
          "integrated.defaultProfile.linux" = "zsh";
          "integrated.defaultProfile.osx" = "zsh";
          "integrated.profiles.osx" = {
            "fish (nix)" = {
              path = "/run/current-system/sw/bin/fish";
            };
          };
        };
        "files" = {
          "autoSave" = "afterDelay";
          "associations" = {
            "*.hs" = "haskell";

            "*.dump-simpl" = "haskell";
            "*.dump-ds" = "haskell";
            "*.project.local" = "haskell";
          };
          "exclude" = {
            "**/.DS_Store" = true;
            "**/.git" = true;
            "**/.hg" = true;
            "**/.lsp" = true;
            "**/.svn" = true;
            "**/.idea" = true;
            "**/CVS" = true;
            "**/Thumbs.db" = true;
          };
        };
        "diffEditor.ignoreTrimWhitespace" = false;
        "vsicons.dontShowNewVersionMessage" = true;
        "liveServer.settings.donotShowInfoMsg" = true;
        "explorer.fileNesting.patterns" = {
          "*.ts" = "\${capture}.js";
          "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
          "*.jsx" = "\${capture}.js";
          "*.tsx" = "\${capture}.ts";
          "tsconfig.json" = "tsconfig.*.json";
          "package.json" = "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb";
          "*.sqlite" = "\${capture}.\${extname}-*";
          "*.db" = "\${capture}.\${extname}-*";
          "*.sqlite3" = "\${capture}.\${extname}-*";
          "*.db3" = "\${capture}.\${extname}-*";
          "*.sdb" = "\${capture}.\${extname}-*";
          "*.s3db" = "\${capture}.\${extname}-*";
        };
        "remote.SSH.configFile" = "~/.ssh/id_ed25519";
        "extensions.ignoreRecommendations" = true;
        "workbench" = {
          "colorTheme" = "Dark Modern";
          "iconTheme" = "vscode-icons";
          "secondarySideBar.defaultVisibility" = "hidden";
        };
        # Language-specific settings
        "haskell" = {
          "formattingProvider" = "fourmolu";
          "manageHLS" = "PATH";
        };
        "[javascript]" = {
          "editor.defaultFormatter" = "typescript-language-features";
        };
        "[javascriptreact]" = {
          "editor.defaultFormatter" = "typescript-language-features";
        };
        "[html]" = {
          "editor.defaultFormatter" = "NikolaosGeorgiou.html-fmt-vscode";
        };
        "[css]" = {
          "editor.defaultFormatter" = "css-language-features";
        };
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
        "[jsonc]" = {
          "editor.defaultFormatter" = "vscode.json-language-features";
        };
        "[python]" = {
          "editor.tabSize" = 4;
          "diffEditor.ignoreTrimWhitespace" = false;
          "editor.defaultColorDecorators" = "never";
          "gitlens.codeLens.symbolScopes" = [ "!Module" ];
          "editor.formatOnType" = true;
          "editor.wordBasedSuggestions" = "off";
        };
        "[c]" = {
          "editor.defaultFormatter" = "xaver.clang-format";
        };
        "mesonbuild.configureOnOpen" = false;
        "github.copilot.enable" = {
          "*" = false;
          "plaintext" = false;
          "markdown" = false;
          "scminput" = false;
        };
        "chat.disableAIFeatures" = true;
        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "nix" = {
          "enableLanguageServer" = true;
          "serverPath" = "nixd";
          "formatterPath" = "nixfmt";
          "serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [
                  "nixfmt"
                ];
              };
              # "options" = {
              #   "nixos" = {
              #     "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").nixosConfigurations.<name>.options";
              #   };
              #   "home-manager" = {
              #     "expr" = "(builtins.getFlake \"/absolute/path/to/flake\").homeConfigurations.<name>.options";
              #   };
              #   "nix-darwin" = {
              #     "expr" = "(builtins.getFlake \"$\{workspaceFolder}/path/to/flake\").darwinConfigurations.<name>.options";
              #   };
              # };
            };
          };
        };
      };
    };
  };
}
