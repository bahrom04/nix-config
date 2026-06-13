{
  description = "bahrom04ʼs nix-config";

  inputs = {
    nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    nix-cachyos-kernel.url = "git+https://git.oss.uzinfocom.uz/mirrors/nix-cachyos-kernel?ref=release&shallow=1";
    xinux-lib = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/lib?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "git+https://git.oss.uzinfocom.uz/mirrors/home-manager?ref=master&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko for easier partition management
    disko = {
      url = "git+https://git.oss.uzinfocom.uz/mirrors/disko?ref=master&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Xinux
    nix-data = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/nix-data?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-style-plymouth = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/xinux-plymouth-theme?ref=master&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xinux-modules = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/modules?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.xinux-settings.follows = "xinux-settings";
      inputs.nix-software-center.follows = "nix-software-center";
      inputs.e-imzo-manager.follows = "e-imzo-manager";
      inputs.xinux-tour.follows = "xinux-tour";
      inputs.bleur.follows = "bleur";
    };
    xinux-settings = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/settings?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-software-center = {
      # url = "github:xinux-org/software-center";
      url = "git+https://git.oss.uzinfocom.uz/xinux/software-center?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # xinux-module-manager = {
    #   url = "github:xinux-org/module-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    e-imzo-manager = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/e-imzo-manager?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xinux-tour = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/xinux-tour?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uz-xkb = {
      url = "github:itsbilolbek/uzbek-linux-keyboard";
      flake = false;
    };
    bleur = {
      url = "git+https://git.oss.uzinfocom.uz/bleur/bleur?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uchar = {
      url = "git+https://git.oss.uzinfocom.uz/uchar/cross?ref=uchar/app/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # snowfall-drift = {
    #   url = "github:snowfallorg/drift";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    #
    # relago = {
    #   url = "github:xinux-org/relago/bootstrap-relago-module";
    #   inputs = {
    #     nixpkgs.follows = "nixpkgs";
    #     # nixpkgs-unstable.follows = "nixpkgs-unstable";
    #   };
    # };
  };

  outputs =
    inputs:
    inputs.xinux-lib.mkFlake {
      inherit inputs;
      src = ./.;

      # Extra nix flags to set
      outputs-builder = channels: {
        formatter = channels.nixpkgs.nixfmt-tree;
      };

      # Globally applied nixpkgs settings
      channels-config = {
        allowUnfree = true;
        allowUnsupportedSystem = true;
        allowUnfreePredicate = _: true;
        allowBroken = true;

        permittedInsecurePackages = [
          "googleearth-pro-7.3.7.1155"
        ];
      };
      # Add modules to all NixOS systems.
      # output should be something meaningfull {}: {}
      # Local ./modules/nixos and ./modules/home imported automaticly
      # a lot of module.nix from remote repos.
      systems.modules.nixos = with inputs; [
        # relago.nixosModules.relago
        disko.nixosModules.disko
        nix-data.nixosModules.nix-data
        xinux-modules.nixosModules.efiboot
        xinux-modules.nixosModules.meta
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
