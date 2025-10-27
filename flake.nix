# ./flake.nix
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
    # flake-utils.url = "github:numtide/flake-utils";

    flake-parts.url = "github:hercules-ci/flake-parts";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # auto_profile_tg = {
    #   url = "github:bahrom04/auto-profile-tg";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # VSCode extension marketplace
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
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
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-darwin"];

      imports = [
        # inputs.flake-parts.flakeModules.modules
        ./hosts/darwin/flake.nix
        ./hosts/matax/flake.nix
        ./hosts/dell/flake.nix
      ];

      flake = {
        homeModules = import ./modules;
      };

      perSystem = {
        inputs,
        pkgs,
        ...
      }: {
        devShells.default = import ./shell.nix {inherit pkgs inputs;};
        formatter = pkgs.alejandra;
      };
    };
}
