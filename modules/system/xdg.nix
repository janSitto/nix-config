{pkgs, ...}: {
  xdg = {
    portal.enable = true;
    portal.extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk 
    ];
  };
}