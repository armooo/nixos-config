{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users.armooo = {
    isNormalUser = true;
    description = "Jason Michalski";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };
}
