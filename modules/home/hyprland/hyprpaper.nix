{ pkgs, wallpaper, ... }:
{

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "${wallpaper}" ];

      wallpaper = [
        "eDP-1,${wallpaper}"
        "HDMI-A-1,${wallpaper}"
      ];
    };
  };
  
}
