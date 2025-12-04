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
  networking.localCommands = ''
     ip rule add to 192.168.10.0/24 priority 2500 lookup main
  '';

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "armooo" ];
    };
  };

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
