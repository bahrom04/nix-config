{
  description = "My NixOS config with nix-darwin + Home Manager";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

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
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    flake-utils,
    ...
  } @ inputs: let
    outputs = self;
  in
    # Attributes for each system
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        # Nixpkgs packages for the current system
        {
          # Development shells
          devShells.default = import ./shell.nix {inherit pkgs;};
          formatter = pkgs.alejandra;
        }
    )
    // {
      homeModules = import ./modules;

      # nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      #   system = "x86_64-linux";
      #   modules = [
      #     ./nixos/pc/configuration.nix
      #   ];

      #   specialArgs = {
      #     inherit inputs outputs;
      #   };
      # };

      darwinConfigurations.air = nix-darwin.lib.darwinSystem {
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
