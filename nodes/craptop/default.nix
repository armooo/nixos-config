{ lib, nixos-hardware, ... }:
{
  imports = [
    ./hardware-configuration.nix
    #nixos-hardware.nixosModules.apple-macbook-pro-11-1
  ];

  nixpkgs.config.allowUnfree = true;

  services.tlp.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;

  networking.hostName = "craptop";

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            rightmeta = "layer(rightmeta)";
          };
          "rightmeta:C" = {};
        };
      };
    };
  };
}
