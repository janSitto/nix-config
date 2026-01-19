{
  config,
  pkgs,
  lib,
  ...
}:
{

  environment.systemPackages = with pkgs; [
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
