# reference: https://maksar.github.io/posts/code/2021-09-19-vscode/
{pkgs, ...}: let
  inherit
    (pkgs.nix4vscode)
    forVscodeVersion
    ;
in {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      # when using nixos-unstable use forVscodeVersion
      # to prevent coming new version every nixos-rebuild
      extensions = forVscodeVersion "1.106.2" [
        "mkhl.direnv"
        "dracula-theme.theme-dracula"
        "yzhang.markdown-all-in-one"
        "ecmel.vscode-html-css"
        "fill-labs.dependi"
        "ms-python.vscode-pylance"
        "ms-python.python"
        "ms-vscode-remote.vscode-remote-extensionpack"
        "ms-vscode-remote.remote-ssh"
        "ms-python.black-formatter"
        "rust-lang.rust-analyzer"
        "zguolee.tabler-icons"
        "vscode-icons-team.vscode-icons"
        "tal7aouy.icons"
        "tamasfe.even-better-toml"
        "kubukoz.nickel-syntax"
        "bbenoist.nix"
        "jnoortheen.nix-ide"
        "mesonbuild.mesonbuild"
        "kamadorueda.alejandra"
        "haskell.haskell"
        "justusadam.language-haskell"
      ];

      userSettings = {
        "files.autoSave" = "afterDelay";

        "[python]"."editor.tabSize" = 4;
        "editor.fontSize" = 16;
        "terminal.integrated.fontSize" = 14;
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.formatOnSave" = true;
        "terminal.integrated.profiles.osx" = {
          "fish (nix)" = {
            path = "/run/current-system/sw/bin/fish";
          };
        };
        "files.associations" = {
          "*.dump-simpl" = "haskell";
          "*.dump-ds" = "haskell";
          "*.project.local" = "haskell";
        };
        "files.exclude" = {
          "**/.DS_Store" = true;
          "**/.git" = true;
          "**/.hg" = true;
          "**/.lsp" = true;
          "**/.svn" = true;
          "**/.idea" = true;
          "**/CVS" = true;
          "**/Thumbs.db" = true;
        };
        "terminal.integrated.defaultProfile.osx" = "zsh";
        "terminal.integrated.defaultProfile.linux" = "zsh";
        "workbench.iconTheme" = "vscode-icons";
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
        "terminal.integrated.inheritEnv" = false;
        "editor.accessibilitySupport" = "off";
        "remote.SSH.configFile" = "~/.ssh/id_ed25519";
        "extensions.ignoreRecommendations" = true;
        "terminal.integrated.suggest" = false;

        # Language-specific settings
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
          "diffEditor.ignoreTrimWhitespace" = false;
          "editor.defaultColorDecorators" = "never";
          "gitlens.codeLens.symbolScopes" = ["!Module"];
          "editor.formatOnType" = true;
          "editor.wordBasedSuggestions" = "off";
        };
        "mesonbuild.configureOnOpen" = false;
        "github.copilot.enable" = {
          "*" = false;
          "plaintext" = false;
          "markdown" = false;
          "scminput" = false;
        };
        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = false;
        };
        "alejandra.program" = "alejandra";
        "nix" = {
          "enableLanguageServer" = true;
          "serverPath" = "nixd";
          "formatterPath" = "alejandra";
          "serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = [
                  "alejandra"
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
