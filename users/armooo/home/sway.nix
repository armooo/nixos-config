{
  lib,
  config,
  pkgs,
  armooo-dotfiles,
  ...
}:
{
  home.file.".config/sway/lot.jpg" = {
    source = "${armooo-dotfiles}/sway/.config/sway/lot.jpg";
  };
  home.file.".config/sway/Sway_Wallpaper_Blue_1920x1080.png" = {
    source = "${armooo-dotfiles}/sway/.config/sway/Sway_Wallpaper_Blue_1920x1080.png";
  };
  home.file.".config/i3status" = {
    source = "${armooo-dotfiles}/sway/.config/i3status";
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

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    systemd.enable = true;
    config = null;
    extraConfig = lib.fileContents "${armooo-dotfiles}/sway/.config/sway/config";
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
    systemdTarget = "sway-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock}/bin/swaylock -f -c 000000 -i ~/.config/sway/lot.jpg";
      }
      {
        event = "lock";
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
