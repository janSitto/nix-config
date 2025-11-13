{pkgs, ...}: {

  qt = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [ 
    kdePackages.qtmultimedia 
    kdePackages.qtsvg
    kdePackages.qtvirtualkeyboard
    libsForQt5.qt5.qtmultimedia
    qt6.qtbase
  ];

}