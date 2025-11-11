{pkgs, ...}: {

  qt = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ 
    kdePackages.qtmultimedia 
    libsForQt5.qt5.qtmultimedia
  ];

}