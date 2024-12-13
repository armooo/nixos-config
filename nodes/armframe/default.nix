{
  lib,
  pkgs,
  pkgs-unstable,
  nixos-hardware,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  services.fwupd.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "armframe";

  # Enable networking
  networking.usePredictableInterfaceNames = false;
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        CountryCountry = "US";
        UseDefaultInterface = false;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  system.stateVersion = "24.11"; # Did you read the comment?
}
