{ ... }:
{
  services.logind.lidSwitch = "suspend-then-hibernate";
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=120min
    # HibernateOnACPower=off
  '';
}
