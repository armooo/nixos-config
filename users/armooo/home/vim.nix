{pkgs, armooo-dotfiles, ...}:
{
programs.vim ={
  enable = true;
  plugins = with pkgs.vimPlugins; [
    flake8-vim
    vim-fugitive
    vim-go
    vim-fish
    vim-jinja
    rust-vim
    vim-autoformat
  ];
};

home.file.".vimrc".source = "${armooo-dotfiles}/vim/.vimrc";

home.packages = [
  pkgs.nixfmt-rfc-style
  pkgs.black
];

}
