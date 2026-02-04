# ./flake.nix
{
  description = "bahrom04ʼs nix-config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Xinux library
    xinux-lib = {
      url = "github:xinux-org/lib/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # VSCode extension marketplace
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Xinux
    xeonitte = {
      url = "github:xinux-org/xeonitte";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-software-center = {
      url = "github:xinux-org/software-center";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xinux-module-manager = {
      url = "github:xinux-org/module-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-conf-editor = {
      url = "github:xinux-org/conf-editor";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hunspell-uz = {
      url = "github:uzbek-net/uz-hunspell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-data = {
      url = "github:xinux-org/nix-data";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    e-imzo-manager = {
      url = "github:xinux-org/e-imzo-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mac-style-plymouth = {
      url = "github:xinux-org/xinux-plymouth-theme";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-drift = {
      url = "github:snowfallorg/drift";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xinux-modules = {
      url = "github:xinux-org/modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    uz-xkb = {
      url = "github:itsbilolbek/uzbek-linux-keyboard";
      flake = false;
    };
  };

  outputs = inputs:
    inputs.xinux-lib.mkFlake {
      inherit inputs;
      src = ./.;

      # Extra nix flags to set
      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };

      # Globally applied nixpkgs settings
      channels-config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
        # Workaround for https://github.com/nix-community/home-manager/issues/2942
        allowUnfreePredicate = _: true;
        allowBroken = true;
      };

      # Add modules to all NixOS systems.
      systems.modules.nixos = with inputs; [
        # packages
        self.nixosModules.apps
        self.nixosModules.boot
        self.nixosModules.desktop
        self.nixosModules.direnv
        self.nixosModules.extension
        self.nixosModules.fonts
        self.nixosModules.keyboard
        self.nixosModules.l10n
        self.nixosModules.network
        self.nixosModules.nixpkgs
        self.nixosModules.users
        self.nixosModules.utils
        self.nixosModules.wallpapers
        self.nixosModules.xinux
        disko.nixosModules.disko

        # a lot of module.nix
        nix-data.nixosModules.nix-data
        xinux-modules.nixosModules.efiboot
        xinux-modules.nixosModules.gnome
        xinux-modules.nixosModules.kernel
        xinux-modules.nixosModules.networking
        xinux-modules.nixosModules.packagemanagers
        xinux-modules.nixosModules.pipewire
        xinux-modules.nixosModules.printing
        xinux-modules.nixosModules.xinux
        xinux-modules.nixosModules.metadata
      ];

      # Default imported modules for all home-manager targets
      homes.modules = with inputs; [
        self.homeModules.zsh
        self.homeModules.git
        self.homeModules.ssh
        self.homeModules.zed
        self.homeModules.fish
        self.homeModules.vscode
        self.homeModules.openssh
        self.homeModules.packages
        self.homeModules.starship
        self.homeModules.fastfetch
      ];

      # Extra project metadata
      xinux = {
        # Namespace for overlay, lib, packages
        namespace = "bahrom";
        # Example: lib.orzklv.match ...

        # For data extraction
        meta = {
          name = "bahrom04";
          title = "bahrom04ʼs Personal Flake Configuration";
        };
      };
    };
}
