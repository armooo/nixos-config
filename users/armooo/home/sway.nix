{
  config,
  pkgs,
  armooo-dotfiles,
  ...
}:
{
  home.file.".config/sway" = {
    source = config.lib.file.mkOutOfStoreSymlink "${armooo-dotfiles}/sway/.config/sway";
    recursive = true;
  };
  home.file.".config/i3status" = {
    source = config.lib.file.mkOutOfStoreSymlink "${armooo-dotfiles}/sway/.config/i3status";
    recursive = true;
  };
  home.packages = with pkgs; [
    sway-audio-idle-inhibit
    i3status
    j4-dmenu-desktop
    foot
  ];
}
