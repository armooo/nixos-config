{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    armooo-dotfiles = {
      url = "github:armooo/dotfiles";
      flake = false;
    };
    virtualfish = {
      url = "github:justinmayer/virtualfish";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      armooo-dotfiles,
      virtualfish,
      ...
    }@inputs:
    {
      # Please replace my-nixos with your hostname
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./nodes/vm
          ./common
          ./configuration.nix
          ./desktop-env
          ./users/armooo
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.armooo = import ./users/armooo/home;
            home-manager.extraSpecialArgs = {
              armooo-dotfiles = armooo-dotfiles;
              virtualfish = virtualfish;
            };
          }
        ];
      };
      nixosConfigurations.craptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Import the previous configuration.nix we used,
          # so the old configuration file still takes effect
          ./nodes/craptop
          nixos-hardware.nixosModules.apple-macbook-pro-11-1
          ./common
          ./configuration.nix
          ./desktop-env
          ./users/armooo
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.armooo = import ./users/armooo/home;
            home-manager.extraSpecialArgs = {
              armooo-dotfiles = armooo-dotfiles;
              virtualfish = virtualfish;
            };
          }
        ];
      };
    };
}
