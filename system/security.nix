{pkgs, ...}: {

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam = {
      services.swaylock = { };
      loginLimits = [
        {
          domain = "@users";
          item = "rtprio";
          type = "-";
          value = 1;
        }
      ];
    };
  };

}