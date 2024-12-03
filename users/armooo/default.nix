{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users.armooo = {
    uid = 1000;
    isNormalUser = true;
    description = "Jason Michalski";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    packages = with pkgs; [
      #  thunderbird
    ];
    shell = pkgs.fish;
  };
}
