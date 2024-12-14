{ pkgs, armooo-dotfiles, ... }:
{
  imports = [
    ./fish.nix
    ./git.nix
    ./ssh.nix
    ./sway.nix
    ./vim.nix
  ];

  home.username = "armooo";
  home.homeDirectory = "/home/armooo";
  home.stateVersion = "24.11";

  home.file.".inputrc".source = "${armooo-dotfiles}/readline/.inputrc";

  programs.home-manager.enable = true;
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    python3
    signal-desktop
    htop
    iotop
    mplayer
    vlc
    pavucontrol
    mpv
  ];
}
