{
  description = "bahrom04ʼs nix-config";

  inputs = {
    nixpkgs.url = "git+https://git.oss.uzinfocom.uz/xinux/nixpkgs?ref=nixos-unstable&shallow=1";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    xinux-lib = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/lib?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Disko for easier partition management
    disko = {
      url = "github:nix-community/disko";
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
    };
    xinux-settings = {
      url = "git+https://git.oss.uzinfocom.uz/xinux/settings?ref=main&shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    uz-xkb = {
      url = "github:itsbilolbek/uzbek-linux-keyboard";
      flake = false;
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
          "googleearth-pro-7.3.6.10201"
        ];
      };
      # Add modules to all NixOS systems.
      # output should be something meaningfull {}: {}
      # Local ./modules/nixos and ./modules/home imported automaticly
      # a lot of module.nix from remote repos.
      systems.modules.nixos = with inputs; [
        disko.nixosModules.disko
        nix-data.nixosModules.nix-data
        xinux-modules.nixosModules.branding
        xinux-modules.nixosModules.kernel
        xinux-modules.nixosModules.xinux
        xinux-modules.nixosModules.gnome
        xinux-modules.nixosModules.graphical
        xinux-modules.nixosModules.shell
        xinux-modules.nixosModules.gaming
        xinux-modules.nixosModules.networking
        xinux-modules.nixosModules.packagemanagers
        xinux-modules.nixosModules.pipewire
        xinux-modules.nixosModules.printing
        # xinux-modules.nixosModules.efiboot
        # xinux-modules.nixosModules.metadata
        # relago.nixosModules.relago
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
