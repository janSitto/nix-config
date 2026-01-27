{ pkgs, ... }:
{

  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.monoid
    nerd-fonts.noto
    nerd-fonts.hack
  ];

}
