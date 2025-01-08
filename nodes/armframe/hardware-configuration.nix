# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/5afcc8f3-3f41-4642-945c-3d7c0695988b";
      fsType = "ext4";
    };

  fileSystems."/mnt/movies" =
    { device = "systemd-1";
      fsType = "autofs";
    };

  fileSystems."/mnt/music" =
    { device = "systemd-1";
      fsType = "autofs";
    };

  fileSystems."/mnt/tv" =
    { device = "systemd-1";
      fsType = "autofs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/D919-290E";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4776bed3-0455-4366-aa41-881bbb3b6650";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/98571501-b4e3-4964-8894-4a55f8628362"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.tailscale0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
