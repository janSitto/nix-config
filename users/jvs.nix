{config, pkgs, ...}: {
    
  sops.secrets = {
    userPassword = { key = "user/password"; };
  };

  users.users.jvs = {
    isNormalUser = true;
    extraGroups = [ "wheel" "users" ];
    hashedPasswordFile = config.sops.secrets.userPassword.path;
    shell = pkgs.bash;
  };
  
}