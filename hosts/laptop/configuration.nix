{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  
  networking.hostName = "nixos";

  nixpkgs.config.permittedInsecurePackages = [
    "libsoup-2.74.3"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [
    ./hardware-configuration.nix
  ];

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.11"; # Did you read the comment?
  };

}