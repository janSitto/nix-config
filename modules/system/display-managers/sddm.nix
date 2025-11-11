{inputs, pkgs, lib, ...}: let

   sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
      theme = "rei"; 
   };

in {

  # This module needs the QT .nix file or qt.enable = true;
  environment.systemPackages = with pkgs; [
    kdePackages.sddm
    sddm-theme 
    sddm-theme.test
  ];

  services.displayManager.sddm = {
      package = pkgs.kdePackages.sddm;
      enable = true;
      theme = sddm-theme.pname;
      extraPackages = sddm-theme.propagatedBuildInputs;
      settings = {
        General = {
          GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
          InputMethod = "qtvirtualkeyboard";
        };
      };
   };


}