{ pkgs, nixos-hardware, ... }:
{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "armframe";

  # Enable networking
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?
}
