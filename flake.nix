# ./flake.nix
{
  description = "My macOS config with nix-darwin + Home Manager";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    # Nixpkgs for darwin
    # nix-darwin = {
    #   url = "github:lnl7/nix-darwin/master";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   # inputs.nixpkgs.follows = "nixpkgs";
    # };

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # VSCode extension marketplace
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Xinux
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
    auto_profile_tg = {
      url = "github:bahrom04/auto-profile-tg";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # Nix script formatter
        formatter = pkgs.alejandra;

        devShells.default = import ./shell.nix {inherit pkgs inputs;};
      }
    )
    // {
      homeModules = import ./modules;

      systems.modules.nixos = with inputs; [
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

      # see: https://isabelroses.com/blog/im-not-mad-im-disappointed/
      nixosConfigurations.matax = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/matax/configuration.nix
        ];

        specialArgs = {
          inherit inputs;
        };
      };

      nixosConfigurations.dell = inputs.nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/dell/configuration.nix
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
}
