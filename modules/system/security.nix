{ pkgs, ... }:
{
  services.gnome.gnome-keyring.enable = true;
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam = {
      services.swaylock = { };
      services.hyprlock = { };
      loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
    };
  };

}
