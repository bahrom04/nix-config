{inputs, ...}: {
  flake = {
    nixosConfigurations.dell = inputs.nixpkgs.lib.nixosSystem {
      # system = "x86_64-linux";
      modules = [
        ./configuration.nix
      ];

      specialArgs = {
        inherit inputs;
      };
    };
  };
}
