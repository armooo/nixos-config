{ nixpkgs, pkgs, ... }:
{
  imports = [
    ./locale.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  environment.systemPackages = with pkgs; [
    git
  ];

  programs.vim = {
    enable = true;
    defaultEditor = true;
  };

  # busted with flakes
  programs.command-not-found.enable = false;

  services.tailscale.enable = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;
  nix.extraOptions =  ''
    keep-outputs = true
  '';
  boot.loader.systemd-boot.configurationLimit = 20;

  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
}
