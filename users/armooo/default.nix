{
  pkgs,
  armooo-dotfiles,
  virtualfish,
  ...
}:
{
  programs.fish.enable = true;
  users.users.armooo = {
    uid = 1000;
    isNormalUser = true;
    description = "Jason Michalski";
    extraGroups = [
      "networkmanager"
      "video"
      "wheel"
    ];
    packages = with pkgs; [
      mosh
      wakeonlan
      nvd
      go
    ];
    shell = pkgs.fish;
  };
  home-manager.users.armooo = import ./home;
  home-manager.extraSpecialArgs = {
    armooo-dotfiles = armooo-dotfiles;
    virtualfish = virtualfish;
  };
}
