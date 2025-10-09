{inputs, ...}: {
  flake = {
    darwinConfigurations.air = inputs.nix-darwin.lib.darwinSystem {
      # system = "aarch64-darwin";
      modules = [
        ./configuration.nix
      ];

      specialArgs = {
        inherit inputs;
      };
    };
  };
}
