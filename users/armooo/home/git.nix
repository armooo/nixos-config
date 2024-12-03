{ pkgs, armooo-dotfiles, ... }:
{
  home.packages = [ pkgs.git ];
  home.file.".gitconfig".source = "${armooo-dotfiles}/git/.gitconfig";
  home.file.".gitignore".source = "${armooo-dotfiles}/git/.gitignore";
}
