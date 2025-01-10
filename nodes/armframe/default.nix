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
    ./disk_encryption.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.fwupd.enable = true;
  services.upower.enable = true;
  services.hardware.bolt.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;

  fileSystems."/".options = ["discard" "data=writeback" "journal_async_commit" "auto_da_alloc"];
  fileSystems."/home".options = ["discard" "data=writeback" "journal_async_commit" "auto_da_alloc"];


  virtualisation.podman.enable = true;


  # It seems there is a bug when amdgpu.abmlevel that kills the backlight now
  #systemd.services.power-profiles-daemon.serviceConfig.ExecStart = [
  #  ""
  #  "${pkgs.power-profiles-daemon}/libexec/power-profiles-daemon --block-action=amdgpu_panel_power"
  #];

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
      Scan = {
        InitialPeriodicScanInterval = 2;
        MaximumPeriodicScanInterval = 120;
      };
    };
  };

  hardware.bluetooth.powerOnBoot = false;

  services.udev.extraRules = ''
    # Suspend the system when battery level drops to 3% or lower
    SUBSYSTEM=="power_supply", ATTR{status}=="Discharging", ATTR{capacity}=="[0-3]", RUN+="${pkgs.systemd}/bin/systemctl hibernate"
  '';

  system.stateVersion = "24.11"; # Did you read the comment?
}
