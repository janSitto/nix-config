{pkgs, ...}: {

    programs.kitty = {
      enable = true;
      font.name = "SF Pro";
      font.size = 10;
      themeFile = "GruvboxMaterialDarkHard";
      extraConfig = ''
        background_opacity 1
        confirm_os_window_close 0
      '';
    };

}