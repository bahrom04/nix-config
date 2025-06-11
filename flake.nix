{
  description = "Starter Configuration with secrets for MacOS and NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-25.05-darwin";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };
  outputs = { self, darwin, home-manager, nixpkgs, ... }@inputs:
    let
      # user = "shakhzod";
      linuxSystems = [ "x86_64-linux" "aarch64-linux" ];
      darwinSystems = [ "aarch64-darwin" "x86_64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs (linuxSystems ++ darwinSystems) f;
      devShell = system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in {
          default = with pkgs;
            mkShell {
              nativeBuildInputs = with pkgs; [
                bashInteractive
                git
                age
              ];
              # shellHook = ''
              #   export EDITOR=vim
              # '';
            };
        };
      mkApp = scriptName: system: {
        type = "app";
        program = "${
            (nixpkgs.legacyPackages.${system}.writeScriptBin scriptName ''
              #!/usr/bin/env bash
              PATH=${nixpkgs.legacyPackages.${system}.git}/bin:$PATH
              echo "Running ${scriptName} for ${system}"
              exec ${self}/apps/${system}/${scriptName}
            '')
          }/bin/${scriptName}";
      };
      mkLinuxApps = system: {
        "apply" = mkApp "apply" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "install" = mkApp "install" system;
        "install-with-secrets" = mkApp "install-with-secrets" system;
      };
      mkDarwinApps = system: {
        "apply" = mkApp "apply" system;
        "build" = mkApp "build" system;
        "build-switch" = mkApp "build-switch" system;
        "copy-keys" = mkApp "copy-keys" system;
        "create-keys" = mkApp "create-keys" system;
        "check-keys" = mkApp "check-keys" system;
        "rollback" = mkApp "rollback" system;
      };
    in {
      devShells = forAllSystems devShell;
      apps = nixpkgs.lib.genAttrs linuxSystems mkLinuxApps
        // nixpkgs.lib.genAttrs darwinSystems mkDarwinApps;

      # darwinConfigurations = nixpkgs.lib.genAttrs darwinSystems (system:

      # formatter.aarch64-darwin = nixpkgs.legacyPackages.${system}.nixfmt-tree;

      darwinConfigurations.powerlaptop = darwin.lib.darwinSystem {
        # inherit system;
        specialArgs = inputs;
        modules = [ home-manager.darwinModules.home-manager ./darwin/home.nix ];
        system = "aarch64-darwin";
        # formatter.aarch64-darwin = nixpkgs.legacyPackages.${system}.nixfmt-tree;
      };
    };
}