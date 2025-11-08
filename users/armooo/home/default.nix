{ pkgs, armooo-dotfiles, ... }:
{
  imports = [
    ./dropbox.nix
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
  services.playerctld.enable = true;

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    binutils
    file
    gdb
    htop
    iotop
    iw
    lutris
    mplayer
    mpv
    pavucontrol
    python3
    signal-desktop
    sxiv
    unzip
    util-linux
    vlc
  ];
}
