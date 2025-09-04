{
  description = "Manage NixOS server remotely";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    colmena.url = "github:zhaofengli/colmena";
    disko ={
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    remoteConfig = {
      url = "github:barnaby0x0/nixos?ref=main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, disko, colmena, remoteConfig, ... }:
    {
      nixosConfigurations.demo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./configuration.nix
        ];
      };
      colmenaHive = colmena.lib.makeHive {
        meta = {
          nixpkgs = nixpkgs.legacyPackages.x86_64-linux;
          remoteConfig = remoteConfig;
        };

        defaults = { pkgs, ... }: {
          environment.systemPackages = [
            pkgs.curl
          ];
        };
        demo = { pkgs, meta, ... }: {
          deployment = {
            targetHost = "<hostname or ip>";
            targetPort = 22;
            targetUser = "user";
            buildOnTarget = true;
            tags = [ "homelab" ];
          };
          nixpkgs.system = "x86_64-linux";
          imports = [
            disko.nixosModules.disko
            meta.remoteConfig.nixosModules.k8
          ];
          time.timeZone = "Europe/Paris";
        };
      };
    };
}
