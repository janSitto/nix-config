{ pkgs, ... }:
{
  gtk = {
    enable = true;
    gtk3 = {
      extraConfig.gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    font = {
      name = "SF Pro";
      size = 11;
    };
    theme = {
      name = "gruvbox-dark";
      package = pkgs.gruvbox-dark-gtk;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
}
