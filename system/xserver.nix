{pkgs, ...}: {
    services.xserver = {
      enable = true;
      xkb = {
        layout = "br";
        model = "abnt2";
        options = "ctrl:nocaps";
      };
    };
}