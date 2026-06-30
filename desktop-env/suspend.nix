{ ... }:
{
  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
  systemd.sleep.settings.Sleep = {
    HibernateDelaySec="120min";
  };
}
