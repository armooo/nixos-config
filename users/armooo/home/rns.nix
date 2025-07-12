{pkgs, ...}:
{
  home.packages = with pkgs; [
    python313Packages.rns
    python313Packages.nomadnet
  ];

  systemd.user.services.rnsd = {
    Unit = {
      Description = "Reticulum node";
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.python313Packages.rns}/bin/rnsd --service --verbose";
      Restart = "always";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
