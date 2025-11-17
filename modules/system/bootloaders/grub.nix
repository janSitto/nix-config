{inputs, config, pkgs, lib, ...}: {

  boot.loader = {
    grub = {
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
  };
  
}