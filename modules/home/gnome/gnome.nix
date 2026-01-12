{ config, pkgs, ... }:
{
  programs.dconf.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.excludePackages = with pkgs; [ xterm ];
  services.gnome.core-apps.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-software
    gnome-tour
  ];
}
