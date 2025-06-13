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

    auto-profile-tg.url = "github:bahrom04/auto-profile-tg";
    
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, auto-profile-tg, ...}@ inputs:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs { inherit system; };
    in {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.${system}.nixfmt-tree;
      
      # todo make let in above to kepp only darwinConfigurations then import some modules  
      darwinConfigurations.bahrom04 = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          inputs.auto-profile-tg.darwinModules.default
          { 
            nix.settings.experimental-features = "nix-command flakes";
            environment.systemPackages = with pkgs; [ 
              nixfmt-rfc-style
		          neovim 
		          fastfetch 
		          redis	
		        ];

            auto-profile-tg = {
              enable = true;
              app-id = "";
              api-hash = "";
              phone-number = "+";
              first-name = "Bahrom";
              lat = "41.2995";
              lon = "69.2401";
              timezone = "Asia/Tashkent";
              weather-api-key = "";
            };

	          services.redis.enable = true;

            programs.fish.enable = true;

            # MacOs Dock setttings
            system.defaults.dock = {
              autohide = false;
              largesize = 16;
              mineffect = "scale";
              minimize-to-application = true;
              mru-spaces = true;
              orientation = "bottom";
              show-recents = false;
              show-process-indicators = true;
              tilesize = 50;
            };

            system.primaryUser = "bahrom04";
              users.users.bahrom04 = {
                name = "bahrom04";
                home = "/Users/bahrom04";
                shell = pkgs.fish;
                uid = 501;
                };
                system.stateVersion = 5;
          }
          
        home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bahrom04 = import ./home.nix;
          }
        
        ];

        specialArgs = {
          inherit inputs;
        };
      };
    };
}
