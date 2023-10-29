{
  description = "NixOS configuration";

  inputs = {
    # nixpkgs input url
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

  ## home manager version
    home-manager = {
      # home manager input url
      url = "github:nix-community/home-manager";
      
      # idk, said to do it
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixvim, disko, ... }: 
  let
    NixHost = "HOSTNAME_REPLACE";
    NixUser = "USERNAME_REPLACE";
  in
  {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      ${NixHost} = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; # Pass flake inputs to our config
        
        modules = [ 
          disko.nixosModules.disko
          
          ./system/configuration.nix

          home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."${NixUser}" = {
                imports = [
                  nixvim.homeManagerModules.nixvim
                  ./home-manager/home.nix 
                ];
              };
            }
        ];
      };
    };
  };
}
