{ nixos-hardware, ... }:
{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.apple-macbook-pro-11-1
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "craptop";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.enable  = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
