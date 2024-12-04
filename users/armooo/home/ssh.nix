{ lib, armooo-dotfiles, ... }:
{
  home.file.".ssh/config".source = "${armooo-dotfiles}/ssh/.ssh/config";

  home.activation = {
    mkCmSocket = lib.hm.dag.entryAfter ["writeBoundary"] ''
    run mkdir -p /home/armooo/.ssh/cm_socket
    '';
  };
}
