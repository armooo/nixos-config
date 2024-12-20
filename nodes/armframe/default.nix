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
  services.upower.enable = true;
  services.hardware.bolt.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;


  # It seems there is a bug when amdgpu.abmlevel that kills the backlight now
  systemd.services.power-profiles-daemon.serviceConfig.ExecStart = [
    ""
    "${pkgs.power-profiles-daemon}/libexec/power-profiles-daemon --block-action=amdgpu_panel_power"
  ];

  # Enable networking
  networking.hostName = "armframe";
  networking.usePredictableInterfaceNames = false;
  networking.networkmanager = {
    enable = true;
    unmanaged = ["type:wifi"];
  };
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = {
        CountryCountry = "US";
        EnableNetworkConfiguration = true;
      };
      Settings = {
        AutoConnect = true;
      };
    };
  };

  hardware.bluetooth.powerOnBoot = false;

  system.stateVersion = "24.11"; # Did you read the comment?
}
