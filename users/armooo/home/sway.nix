{
  lib,
  config,
  pkgs,
  armooo-dotfiles,
  ...
}:
{
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
      bars = [
        {
          command = "${pkgs.waybar}/bin/waybar";
          mode = "dock";
          position = "bottom";
        }
      ];
      window.commands = [
        {
          command = "move scratchpad, resize set 920 600";
          criteria = {
            app_id = "signal";
          };
        }
        {
          command = "floating enable";
          criteria = {
            app_id = "org.pulseaudio.pavucontrol";
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
        "${modifier}+Ctrl+l" = "exec ${pkgs.hyprlock}/bin/hyprlock";
        "${modifier}+n" = "exec ${pkgs.swaynotificationcenter}/bin/swaync-client -t -sw";
        "${modifier}+p" = "[app_id=\"signal\"] scratchpad show";
        "${modifier}+Shift+s" = "sticky toggle";
        XF86AudioMute = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
        XF86AudioRaiseVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        XF86AudioLowerVolume = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
      };
    };
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings.main = {
      font = "Inconsolata:size=10, Symbols Nerd Font:size=9";
    };
  };

  home.packages = with pkgs; [
    inconsolata
    nerdfonts
    i3status
    j4-dmenu-desktop
    sway-audio-idle-inhibit
    swaynotificationcenter

  ];

  services.swayidle = {
    enable = true;
    systemdTarget = "sway-session.target";
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        event = "lock";
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.hyprlock}/bin/hyprlock";
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

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        # enable_fingerprint = true;
      };
      background = {
        path = "${armooo-dotfiles}/sway/.config/sway/lot.jpg";
        blur_passes = 2;
        contrast = 1;
        brightness = 0.5;
        vibrancy = 0.2;
        vibrancy_darkness = 0.2;
      };
      "input-field" = {
        size = "350, 100";
        outline_thickness = 2;
        outer_color = "rgba(0, 0, 0, 0)";
        inner_color = "rgba(0, 0, 0, 0.2)";
        font_color = "rgba(170, 170, 170, 0)";
        fade_on_empty = "false";
        rounding = -1;
        check_color = "rgb(204, 136, 34)";
        placeholder_text = "<i><span foreground=\"##cdd6f4\">Input Password...</span></i>";
        hide_input = "true";
        position = "0, -200";
        halign = "center";
        valign = "center";
      };
      label =[
        {
          text = "$FPRINTMESSAGE";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 16;
          font_family = "JetBrains Mono";
          position = "0, -300";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] ${pkgs.coreutils}/bin/date +'%A, %B %d'";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 22;
          font_family = "JetBrains Mono";
          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] ${pkgs.coreutils}/bin/date +%-I:%M";
          color = "rgba(242, 243, 244, 0.75)";
          font_size = 95;
          font_family = "JetBrains Mono";
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        ipc = true;
        exclusive = false;
        layer = "top";
        position = "bottom";
        height = 20;
        spacing = 5;
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-right = [
          "network"
          "custom/spacer"
          "battery"
          "custom/spacer"
          "wireplumber"
          "custom/spacer"
          "power-profiles-daemon"
          "custom/spacer"
          "clock#1"
          "custom/spacer"
          "clock#2"
          "tray"
        ];

        "custom/spacer" = {
          format = "|";
        };

        network = {
          format-wifi = "{icon} {essid} {signalStrength}%";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          on-click = "$(pkgs.idwgui)";
          tooltip-format = "{frequency}hz {signaldBm}dBm {ipaddr}";
        };

        battery = {
          format = "{icon} {capacity}% {power:2.0f}W";
          format-icons = [
            ""
            ""
            ""
            ""
          ];
          tooltip-format = "{time}";
        };

        wireplumber = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          scroll-step = 5;
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };

        power-profiles-daemon = {
          format-icons = {
            default = "󰤇" ;
            performance = "󰤇 ";
            balanced = "󰗑 ";
            power-saver = "󰳗 ";
          };
        };

        "clock#1" = {
          format = "{:%FT%I:%M}PT";
          timezone = "America/Los_Angeles";
          tooltip = false;
        };

        "clock#2" = {
          format = "{:%FT%H:%M}Z";
          timezone = "UTC";
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        font-family: Inconsolata Nerd Font;
        font-size: 16px;
        min-height: 0px;
        padding: 0;
        margin: 0;
        border-radius: 0px;
      }

      #waybar {
        color: #eff0f1;
        background-color: #000000;
      }

      #custom-spacer {
        color: #666666;
      }

      #workspaces button {
        min-width: 16px;
        min-height: 16px;
        background-color: #222222;
        color: #666666;
      }

      #workspaces button.focused {
        color: #ffffff;
        background-color: #285577;
      }

      #workspaces button.urgent {
        background-color: red;
      }
    '';
  };
}
