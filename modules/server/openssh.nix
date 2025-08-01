{pkgs, ...}: {
    services.openssh = {
    enable = true;
    ports = [ 7830 ];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null;
      UseDns = false;
      PermitRootLogin = "no";   
    };
  };
}