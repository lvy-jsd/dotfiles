  {
    description = "HP EliteBook 845 G9 Flake with Rolling Release & Home Manager";

    #
    inputs = {
      #
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

      #
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";

      #
      zen-browser.url = "github:0xc000022070/zen-browser-flake";
      zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    };

    #
    outputs = { self, nixpkgs, home-manager, zen-browser, ... }@inputs: {
      nixosConfigurations.ilo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
	modules = [
	  #
	  ./hardware-configuration.nix
	  ./configuration.nix

	  #
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.extraSpecialArgs = { inherit inputs; };
	    home-manager.users.lvy = import ./home.nix;
	  }
	];
      };
    };
  }
