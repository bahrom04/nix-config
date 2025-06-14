# ~/nix-config/flake.nix
{
  description = "My macOS config with nix-darwin + Home Manager";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";

    # Nixpkgs for darwin
    nix-darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";

    # Theme version as Nixpkgs
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    inputs.sops-nix.url = "github:Mic92/sops-nix";
    # optional, not necessary for the module
    #inputs.sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    auto-profile-tg.url = "github:bahrom04/auto-profile-tg";
  };

  outputs = {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  } @ inputs: let
    outputs = self;
    system = "aarch64-darwin";
    pkgs = import nixpkgs {inherit system;};
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.aarch64-darwin.default = import ./shell.nix {inherit pkgs;};

    # todo make let in above to kepp only darwinConfigurations then import some modules
    darwinConfigurations.bahrom04 = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager

        ./darwin/configuration.nix

        inputs.auto-profile-tg.darwinModules.default
      ];

      specialArgs = {
        inherit inputs outputs;
      };
    };
  };
}
