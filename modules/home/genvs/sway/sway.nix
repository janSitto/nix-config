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

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

}
