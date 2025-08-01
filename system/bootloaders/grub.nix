{pkgs, ...}: {

  boot.loader = {
    grub.device = "nodev";
    grub.efiSupport = true;
    efi.canTouchEfiVariables = true;
  };
  
}