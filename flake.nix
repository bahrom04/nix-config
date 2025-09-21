# ~/nix-config/flake.nix
{
  description = "My macOS config with nix-darwin + Home Manager";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Nixpkgs for darwin
    nix-darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Flake utils for eachSystem
    flake-utils.url = "github:numtide/flake-utils";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    auto_profile_tg = {
      url = "github:bahrom04/auto-profile-tg";
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
    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  } @ inputs: let
    outputs = self;
  in
    # Attributes for each system
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };
      in
        # Nixpkgs packages for the current system
        {
          # Development shells
          devShells.default = import ./shell.nix {inherit pkgs;};
          formatter = pkgs.alejandra;
        }
    )
    // {
      # nixosModules = import ./modules/nixos;
      # darwinModules = import ./modules/darwin;
      homeModules = import ./modules;

      nixosConfigurations.matax = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos/matax/configuration.nix
        ];

        specialArgs = {
          inherit inputs outputs;
        };
      };

      darwinConfigurations.air = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./nixos/darwin/configuration.nix
        ];

        specialArgs = {
          inherit inputs outputs;
        };
      };
    };
}
