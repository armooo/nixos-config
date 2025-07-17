{
  nixpkgs,
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

  nixpkgs.overlays = [
    (self: super: {
      ollama = super.ollama.overrideAttrs (finalAttrs: previousAttrs: {
         version = "9.7.9arm";
         vendorHash = "sha256-oHTo8EQGfrKOwg6SRPrL23qSH+p+clBxxiXsuO1auLk=";
         src = super.fetchFromGitHub {
           owner = "crandel";
           repo = "ollama-amd-igpu";
           rev = "95e1e05cb56275a8f694116f836174e9c0463042";
           hash = "sha256-zu2jnH4R5TGxN//LCHzdtWfmQmG0zuVU4FVv6uppF1Q=";
           fetchSubmodules = true;
         };
		ldflags = [
		  "-s"
		  "-w"
		  "-X=github.com/ollama/ollama/version.Version=${finalAttrs.version}"
		  "-X=github.com/ollama/ollama/server.mode=release"
		];
		postPatch = ''
		  substituteInPlace version/version.go \
			--replace-fail 0.0.0 '${finalAttrs.version}'
		'';
      });
   })
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.fwupd.enable = true;
  services.upower.enable = true;
  services.hardware.bolt.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.memtest86.enable = true;

  fileSystems."/".options = ["discard" "auto_da_alloc"];
  fileSystems."/home".options = ["discard" "auto_da_alloc"];


  virtualisation.podman.enable = true;


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
      IPv6 = {
        enable = true;
      };
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

  services.ollama = {
	enable = true;
	acceleration = "rocm";
    rocmOverrideGfx = "11.0.2";
  };
  services.open-webui.enable = true;


  system.stateVersion = "24.11"; # Did you read the comment?
}
