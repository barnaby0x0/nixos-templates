{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      lib = nixpkgs.lib;
      systems = [ "x86_64-linux" ];
      sharedArgs = {
        inherit lib;
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
      };
      paths = {
        vagrant = {
          configuration_file = "${self}/configuration.nix";
        };
      };      
      homeManagerModule = home-manager.nixosModules.home-manager;
      homeManagerSettings = {
        users.mutableUsers = false;
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
        };
      };

    in {
      nixosConfigurations = {
        vagrant = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            paths.vagrant.configuration_file
            {
              nixpkgs.config.allowUnfreePredicate = pkg: 
                builtins.elem (lib.getName pkg) ["vscode"];
            }
            homeManagerModule
            {
              home-manager.extraSpecialArgs = {};
            }
            homeManagerSettings
          ];
        };

    };
  };
}
