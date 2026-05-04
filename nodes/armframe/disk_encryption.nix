{
  pkgs,
  config,
  ...
}:
{
  environment.systemPackages = [
    pkgs.cryptsetup
    pkgs.fscrypt-experimental
  ];

  boot.initrd.systemd.emergencyAccess = "$7$GU..../....bTbQZYsqcj45Zhkl2q9OH.$RagcUFlC0P3gikVxL9xjHFtm9hb8EnM.h6B4vZPysl6";
  boot.initrd.systemd.enable = true; # for tpm2 unlock
  boot.initrd.luks.devices.swap = {
    device = "/dev/disk/by-uuid/a8f2ce7e-fc22-46dd-879b-6a4b0833af1f";
    allowDiscards    = true;
    bypassWorkqueues = true;
  };
  boot.initrd.luks.devices.root = {
    allowDiscards    = true;
    bypassWorkqueues = true;
    crypttabExtraOpts = [
      "tpm2-device=auto"
      "tpm2-measure-pcr=yes"
    ];
  };

  security.pam.enableFscrypt = true;
}
