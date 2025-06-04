{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
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
      lanzaboote,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          armooo-dotfiles = armooo-dotfiles;
          virtualfish = virtualfish;
          nixos-hardware = nixos-hardware;
        };
        modules = [
          ./nodes/vm
          ./common
          ./desktop-env
          ./users/armooo
          home-manager.nixosModules.home-manager
        ];
      };
      nixosConfigurations.craptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          armooo-dotfiles = armooo-dotfiles;
          virtualfish = virtualfish;
          nixos-hardware = nixos-hardware;
        };
        modules = [
          ./nodes/craptop
          ./common
          ./desktop-env
          ./users/armooo
          home-manager.nixosModules.home-manager
        ];
      };
      nixosConfigurations.armframe = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          armooo-dotfiles = armooo-dotfiles;
          virtualfish = virtualfish;
          nixos-hardware = nixos-hardware;
          lanzaboote = lanzaboote;
        };
        modules = [
          ./nodes/armframe
          ./common
          ./desktop-env
          ./users/armooo
          ./systemd-resolved.nix
          ./secure_boot.nix
          home-manager.nixosModules.home-manager
        ];
      };
    };
  }
