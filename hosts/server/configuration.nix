
{config, lib, pkgs, ...}:
{
  
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
     wget
     curl
     jq
     git
     lm_sensors
  ];

  networking.hostName = "nixos-server"; 

  # Networking
  boot.kernel.sysctl."net.ipv4.ip_forward" = true;
  networking = {
    
    # Firewall 
    firewall = {
      enable = true;
      allowPing = true;
      allowedTCPPorts = [ 7830 445 137 138 139 80 443 ];
      allowedUDPPorts = [ 7830 445 137 138 139 80 443 41641 ];
    };
    
    # NAT
    nat = {
      enable = true;
      externalInterface = "eth0";
    };

  };

  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports = [ 
    ./hardware-configuration.nix
  ];

  system = {
    copySystemConfiguration = false;
    stateVersion = "24.11"; # Did you read the comment?
  };

}

 