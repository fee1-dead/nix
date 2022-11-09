{
  description = "Home Manager flake";
  inputs = {
      nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
      home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
      };
  };
  outputs = { self, nixpkgs, home-manager }: {
	defaultPackage.x86_64-linux = home-manager.defaultPackage.x86_64-linux;
	homeConfigurations = {
		"beef" = home-manager.lib.homeManagerConfiguration {
			pkgs = import nixpkgs {
				system = "x86_64-linux";
				config.allowUnfree = true;
			};
			modules = [ ./home.nix ];
		};
	};
  };
}
