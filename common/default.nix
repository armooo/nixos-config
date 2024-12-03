{ pkgs, ... }:
{
    imports = [
        ./locale.nix
    ];

    nix.settings.experimental-features = ["nix-command" "flakes"];
    environment.systemPackages = with pkgs; [
     vim
     git
   ];

   services.tailscale.enable = true;
}
