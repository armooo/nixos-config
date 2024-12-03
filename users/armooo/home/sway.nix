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

  services.gnome-keyring.enable = true;
  programs.fish.interactiveShellInit = "set -gx SSH_AUTH_SOCK /run/user/1000/keyring/ssh";

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 16;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  home.packages = with pkgs; [
    sway-audio-idle-inhibit
    i3status
    j4-dmenu-desktop
    foot
  ];
}
