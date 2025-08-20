{pkgs, lib, ...}: {

  #users.users.sddm = {
  #  isSystemUser = true;
  #  group = "sddm";
  #};
  #users.groups.sddm.members = [];

  environment.systemPackages = with pkgs; [
    kdePackages.sddm
    (catppuccin-sddm.override {
      flavor = "macchiato";
      font = "Sf Pro";
      fontSize = "9";
      #background = "${wallpaper}";
      loginBackground = true;
    })
  ];

  services.displayManager = {
    #defaultSession = "hyprland";
    sddm = {
      enable = true;
      wayland.enable = false;
      theme = "catppuccin-macchiato";
      package = lib.mkForce pkgs.kdePackages.sddm;
    };
  };

  #systemd.tmpfiles.rules = [
  #  "d /run/sddm 0755 sddm sddm -"
  #];

}