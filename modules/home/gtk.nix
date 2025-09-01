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
      name = "Gruvbox-Material-Dark-Hard";
      package = pkgs.gruvbox-material-gtk-theme;
    };
    iconTheme = {
      name = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };
}
