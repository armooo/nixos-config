{ pkgs, armooo-dotfiles, ... }:

{
  programs.vim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      flake8-vim
      vim-fugitive
      vim-go
      vim-fish
      vim-jinja
      rust-vim
      vim-autoformat
      (pkgs.vimUtils.buildVimPlugin {
        name = "desert";
        src = pkgs.fetchFromGitHub {
          owner = "vim-scripts";
          repo = "desert.vim";
          rev = "0141b8809cadace616b87c9e50a94d46d4978dd6";
          hash = "sha256-LHvWELlM3d2+/eTfm2YbsRfUXLRBUAjZwRDd6SZH8R4=";
        };
      })
    ];
    extraConfig = (builtins.readFile "${armooo-dotfiles}/vim/.vimrc") + ''
      let g:autoformat_autoindent = 0
      let g:autoformat_retab = 0
      let g:autoformat_remove_trailing_spaces = 0
    '';
  };

  home.packages = [
    pkgs.nixfmt-rfc-style
    pkgs.black
  ];

}
