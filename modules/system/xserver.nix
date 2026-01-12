{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "br,us";
      model = "abnt2";
      options = "ctrl:nocaps,grp:ctrl_space_toggle";
    };
  };
}

