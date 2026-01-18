{
  config,
  pkgs,
  inputs,
  username,
  userpfp,
  wallpaper,
  ...
}:
{

  imports = [
    ../modules/home/genvs/sway/sway-config.nix
    ../modules/home/waybar/waybar.nix
    ../modules/home/wofi/wofi.nix
    ../modules/home/gtk.nix
    ../modules/home/dconf.nix
    ../modules/home/kitty.nix
    ../modules/home/editors/helix.nix
    ../modules/home/editors/nvf.nix
  ];

  xdg.userDirs.enable = false;

  home = {
    username = "${username}";
    file.".face".source = "${userpfp}";
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";

    packages = with pkgs; [
      brightnessctl
      hyprpaper
      hyprshot
      hyprland-qtutils
      libsForQt5.qtstyleplugins
      libsForQt5.qt5ct
      bibata-cursors
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GTK_USE_PORTAL = "1";
      GTK_THEME = "gruvbox-material-dark-hard";
    };

    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Classic";
      size = 8;
    };

  };

}
