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
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

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
