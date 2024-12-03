{ pkgs, armooo-dotfiles, virtualfish, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "virtualfish";
        src = virtualfish;
      }
    ];
  };
  home.file.".config/fish" = {
    source = "${armooo-dotfiles}/fish/.config/fish";
    recursive = true;
  };
  home.packages = [
    pkgs.python3
  ];
}
