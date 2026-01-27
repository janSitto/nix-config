{ pkgs, ... }:
{
  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config = {
        common = {
          default = "wlr";
        };
      };
      wlr = {
        enable = true;
        settings.screencast = {
          output_name = "DP-2";
          chooser_type = "simple";
          chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
        };
      };
    };
  };
}
