{ pkgs, ... }:
let
  virtualisation_username = "jvs";
in
{

  virtualisation.libvirtd.enable = true;
  environment.systemPackages = with pkgs; [
    qemu
    virt-manager
  ];

  users.extraGroups.libvirtd.members = [ "${virtualisation_username}" ];
  users.extraGroups.kvm.members = [ "${virtualisation_username}" ];

}

