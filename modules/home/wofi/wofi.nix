{ pkgs, ... }:
{
  home.file.".config/wofi/style.css".source = ./wofi.css;
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      location = "top-left";
      allow_markup = true;
      width = 500;
    };
  };
}
