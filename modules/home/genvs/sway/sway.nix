{
  config,
  pkgs,
  lib,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    swaylock
    grim
    slurp
    wl-clipboard
    mako
  ];

  programs = {
    light.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };

}
