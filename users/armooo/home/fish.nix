{
  pkgs,
  armooo-dotfiles,
  virtualfish,
  ...
}:
{
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "virtualfish";
        src = virtualfish;
      }
    ];
    interactiveShellInit = ''
      set -gx SSH_AUTH_SOCK /run/user/1000/keyring/ssh
    '';
  };
  home.file.".config/fish/completions" = {
    source = "${armooo-dotfiles}/fish/.config/fish/completions";
    recursive = true;
  };
  home.file.".config/fish/functions" = {
    source = "${armooo-dotfiles}/fish/.config/fish/functions";
    recursive = true;
  };
  home.packages = [
    pkgs.python3
  ];
}
