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

  # Enable networking
  networking.hostName = "armframe";
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

  # seems to cause an oops in btusb_suspend+0x161/0x200 [btusb]
  hardware.bluetooth.powerOnBoot = false;

  # work around hang
  #systemd.services.bt-hang-hack = {
  #  enable = true;
  #  description = "Disable Bluetooth before going to sleep";
  #  before = [ "sleep.target" ];
  #  wantedBy = [ "sleep.target" ];
  #  unitConfig = {
  #    StopWhenUnneeded = "yes";
  #  };
  #  serviceConfig = {
  #    Type = "oneshot";
  #    RemainAfterExit = "yes";
  #    ExecStart = "${pkgs.util-linux}/bin/rfkill block bluetooth";
  #    ExecStop = "${pkgs.util-linux}/bin/rfkill unblock bluetooth";
  #  };
  #};

  system.stateVersion = "24.11"; # Did you read the comment?
}
