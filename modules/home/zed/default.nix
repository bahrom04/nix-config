{
  lib,
  pkgs,
  config,
  ...
}:
let
  extensions = [
    "assembly"
    "deno"
    "env"
    "glsl"
    "haskell"
    "html"
    "ini"
    "just"
    "latex"
    "lua"
    "make"
    "material-icon-theme"
    "neocmake"
    "nginx"
    "nix"
    "nu"
    "pkl"
    "ruby"
    "slint"
    "sql"
    "swift"
    "toml"
    "typst"
    "vercel-theme"
    "wgsl"
    "xml"
    "zig"
    "meson"
  ];

  userSettings = {
    auto_update = false;
    # colorize_brackets = true;
    disable_ai = true;

    preview_tabs = {
      enabled = false;
    };

    telemetry = {
      metrics = false;
      diagnostics = false;
    };

    show_edit_predictions = false;

    node = {
      path = lib.getExe pkgs.nodejs;
      npm_path = lib.getExe' pkgs.nodejs "npm";
    };

    languages = {
      Markdown = {
        format_on_save = "on";
        use_on_type_format = true;
        remove_trailing_whitespace_on_save = true;
      };

      Nix = {
        formatter = "language_server";
        # colorize_brackets = true;
        language_servers = [
          "nixd"
          "!nil"
        ];
      };

      TypeScript = {
        language_servers = [
          "typescript-language-server"
          "deno"
          "!vtsls"
          "!eslint"
        ];
        formatter = "language_server";
      };

      TSX = {
        language_servers = [
          "typescript-language-server"
          "deno"
          "!eslint"
          "!vtsls"
        ];
        formatter = "language_server";
      };
    };

    lsp = {
      nixd = {
        binary = {
          ignore_system_version = false;
        };
        settings = {
          formatting = {
            command = [
              "nixfmt"
            ];
          };
          diagnostic = {
            suppress = [
              "sema-extra-with"
              "sema-extra-rec"
            ];
          };
        };
      };

      rust-analyzer = {
        binary = {
          ignore_system_version = false;
        };
        initialization_options = {
          check = {
            command = "clippy";
          };
        };
      };

      deno = {
        binary = {
          ignore_system_version = false;
        };
      };

      solargraph = {
        binary = {
          ignore_system_version = false;
        };
        initialization_options = {
          diagnostics = true;
          formatting = true;
        };
      };
    };

    load_direnv = "shell_hook";

    theme = {
      mode = "system";
      light = "VSCode Dark Modern";
      dark = "VSCode Dark Modern";
    };
    icon_theme = "VSCode Icons for Zed (Dark)";

    tab_size = 2;
    preferred_line_length = 100;

    autosave.after_delay.milliseconds = 500;
    format_on_save = "on";
    enable_language_server = true;

    soft_wrap = "editor_width";

    buffer_font_size = 14;
    buffer_font_family = "Adwaita Mono";

    ui_font_size = 14;
    ui_font_family = ".SystemUIFont";

    confirm_quit = false;
    use_autoclose = false;

    inlay_hints = {
      enabled = true;
      # show_background = true;
    };

    title_bar = {
      show_branch_icon = true;
    };

    collaboration_panel = {
      button = false;
    };

    agent = {
      enabled = false;
    };
  };
in
{
  config = {
    programs.zed-editor = {
      enable = true;
      inherit extensions userSettings;
      installRemoteServer = true;
      package = pkgs.zed-editor;
      extraPackages = config.programs.helix.extraPackages;
    };
  };
}
