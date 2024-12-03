{ pkgs, ... }:
let
  shares = [
    "movies"
    "music"
    "tv"
  ];
in
{

  environment.systemPackages = [
    pkgs.cifs-utils
  ];

  systemd.mounts = map (share: {
    description = "${share}";
    what = "//file-server.ts.armooo.net/${share}";
    where = "/mnt/${share}";
    type = "cifs";
    options = "guest";
    mountConfig = {
      TimeoutSec = 15;
    };
  }) shares;

  systemd.automounts = map (share: {
    where = "/mnt/${share}";
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "5m";
    };
  }) shares;
}
