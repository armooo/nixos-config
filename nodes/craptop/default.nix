{ nixos-hardware, ... }:
{
  imports = [
    nixos-hardware.nixosModules.apple-macbook-pro-11-1
  ]

  networking.hostName = "craptop";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.wireless.enable  = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
