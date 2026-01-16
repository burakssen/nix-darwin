{
  description = "burakssen nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#burakssen
    darwinConfigurations."burakssen" = nix-darwin.lib.darwinSystem {
      modules = [ 
	./hosts/burakssen/default.nix
	home-manager.darwinModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.extraSpecialArgs = { inherit inputs; };
	  home-manager.users.burakssen = ./home.nix;
	}
      ];
      specialArgs = { inherit inputs; };
    };
  };
}
