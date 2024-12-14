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
    config = {
      modifier = "Mod4";
      input = {
        "type:touchpad" ={
          dwt = "enabled";
          tap = "disabled";
          natural_scroll = "disabled";
          middle_emulation = "enabled";
          scroll_factor = ".4";
          click_method = "clickfinger";
        };
      };
      window.commands = [
        {
          command = "move scratchpad, resize set 920 600";
          criteria = {
            app_id = "signal";
          };
        }
      ];
      startup = [
        {
          command = "${pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland";
        }
      ];
      keybindings = let
        modifier = config.wayland.windowManager.sway.config.modifier;
      in lib.mkOptionDefault {
        "${modifier}+Ctrl+l" = "exec ${pkgs.swaylock}/bin/swaylock -f -c 000000 -i ~/.config/sway/lot.jpg";
        "${modifier}+n" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        "${modifier}+p" = "[app_id=\"signal\"] scratchpad show";
        "${modifier}+Shift+s" = "sticky toggle";
        XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
      };
    };
  };

  home.packages = with pkgs; [
    swaylock
    sway-audio-idle-inhibit
    i3status
    j4-dmenu-desktop
    foot
    swaynotificationcenter
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
        timeout = 330;
        command = "${pkgs.sway}/bin/swaymsg \"output * dpms off\"";
        resumeCommand = "${pkgs.sway}/bin/swaymsg \"output * dpms on\"";
      }
      {
        timeout = 340;
        command = "[ \"$(${pkgs.coreutils}/bin/cat /sys/class/power_supply/BAT*/status)\" = \"Discharging\" ] && ${pkgs.systemd}/bin/systemctl hybrid-sleep";
      }
    ];
  };

  services.swaync = {
    enable = true;
  };

  services.kanshi = {
    enable = true;
    settings = [
      {
        profile = {
          name = "undocked";
          exec = [
            "${pkgs.networkmanager}/bin/nmcli device connect wlan0"
          ];
          outputs = [
            {
              criteria = "eDP-1";
            }
          ];
        };
      }
      {
        profile = {
          name = "desk";
          exec = [
            "${pkgs.networkmanager}/bin/nmcli device disconnect wlan0"
          ];
          outputs = [
            {
              criteria = "eDP-1";
              position = "5372,1497";
            }
            {
              criteria = "LG Electronics LG UltraFine 203NTCZHT347";
              position = "3360,1061";
              scale = 2.0;
            }
          ];
        };
      }
    ];
  };
}
