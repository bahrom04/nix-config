{pkgs, ...}: let
  extensions = [
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
    "slint"
    "sql"
    "toml"
    "typst"
    "vercel-theme"
    "wgsl"
    "xml"
    "zig"
  ];

  settings = {
    auto_update = true;

    disable_ai = true;

    telemetry = {
      metrics = false;
      diagnostics = false;
    };

    show_edit_predictions = true;

    languages = {
      Markdown = {
        format_on_save = "on";
        use_on_type_format = true;
        remove_trailing_whitespace_on_save = true;
      };

      Nix = {
        formatter = "language_server";
        language_servers = [
          "nixd"
          "!nil"
        ];
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
              "alejandra"
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
      light = "Ayu Light";
      dark = "Ayu Mirage";
    };
    icon_theme = "Material Icon Theme";

    tab_size = 2;
    preferred_line_length = 100;

    autosave = "after_delay";
    format_on_save = "language_server";
    enable_language_server = true;

    soft_wrap = "editor_width";

    buffer_font_size = 16;
    buffer_font_family = "mononoki";

    ui_font_size = 16;
    ui_font_family = "mononoki";

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

    chat_panel = {
      button = "never";
    };

    agent = {
      enabled = false;
    };
  };
in {
  config = {
    programs.zed-editor = {
      enable = true;
      inherit extensions;
      userSettings = settings;
      installRemoteServer = true;
      extraPackages = with pkgs; [nixd];
    };
  };
}