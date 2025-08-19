{pkgs, ...}: {

    programs.kitty = {
      enable = true;
      font.name = "SF Pro";
      font.size = 10;
      themeFile = "GruvboxMaterialDarkHard";
      extraConfig = ''
        background_opacity 0.5
        confirm_os_window_close 0
      '';
    };

}