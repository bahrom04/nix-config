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

    relago = {
      url = "github:xinux-org/relago/bootstrap-relago-module";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        # nixpkgs-unstable.follows = "nixpkgs-unstable";
      };
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
        allowUnfreePredicate = _: true;
        allowBroken = true;

        permittedInsecurePackages = [
          "googleearth-pro-7.3.6.10201"
        ];
      };

      # Add modules to all NixOS systems. 
      # output should be something meaningfull {}: {}
      # Locals imported autom automaticly
      # a lot of module.nix from remote repos.
      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        nix-data.nixosModules.nix-data
        relago.nixosModules.relago
      ];

      # homes.modules = with inputs; [
        # nix-data.nixosModules.nix-data
        # relago.nixosModules.relago
      # ];

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
