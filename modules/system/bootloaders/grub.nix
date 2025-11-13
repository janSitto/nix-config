{inputs, config, pkgs, lib, ...}: {

  boot.loader = {
    grub = {
      device = "nodev";
      efiSupport = true;
    };
    grub2-theme = {
      enable = true;
      theme = "vimix";
      footer = true;
    };
    efi.canTouchEfiVariables = true;
  };
  
}