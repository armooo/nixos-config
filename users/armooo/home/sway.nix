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
          command = "swaylock -f -c 000000 -i ~/.config/sway/lot.jpg";
        }
    ];
    timeouts = [
      {
        timeout = 300;
        command = "swaylock -f -c 000000 -i ~/.config/sway/lot.jpg";
      }
      {
        timeout = 600;
        command = "systemctl hybrid-sleep";
      }
    ];
  };
}
