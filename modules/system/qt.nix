{pkgs, ...}: {

  qt = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ kdePackages.qtmultimedia ];

}