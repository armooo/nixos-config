{ lib, armooo-dotfiles, ... }:
{
  home.file.".ssh/config".source = ./ssh_config;

  home.activation = {
    mkCmSocket = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run mkdir -p /home/armooo/.ssh/cm_socket
    '';
  };
}
