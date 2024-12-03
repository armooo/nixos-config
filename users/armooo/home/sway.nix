{ pkgs, armooo-dotfiles,  ... }:
{
  home.file.".config/sway" = {
    source = "${armooo-dotfiles}/sway/.config/sway";
    recursive = true;
  };
  home.packages = [
    pkgs.sway-audio-idle-inhibit
  ];
}
