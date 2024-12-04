{
  config,
  pkgs,
  armooo-dotfiles,
  ...
}:
{
  home.file.".config/sway" = {
    source = config.lib.file.mkOutOfStoreSymlink "${armooo-dotfiles}/sway/.config/sway";
    recursive = true;
  };
  home.file.".config/i3status" = {
    source = config.lib.file.mkOutOfStoreSymlink "${armooo-dotfiles}/sway/.config/i3status";
    recursive = true;
  };

  services.gnome-keyring.enable = true;

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 16;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };

  home.packages = with pkgs; [
    swaylock
    sway-audio-idle-inhibit
    i3status
    j4-dmenu-desktop
    foot
  ];

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000 -i ~/.config/sway/lot.jpg";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000 -i ~/.config/sway/lot.jpg";
      }
      {
        timeout = 600;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
      {
        timeout = 1800;
        command = "[ \"$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/BAT0/status)\" = \"Discharging\" ] && ${pkgs.systemd}/bin/systemctl hybrid-sleep";
      }
    ];
  };
}
