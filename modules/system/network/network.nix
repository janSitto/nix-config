{ pkgs, username, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
    };

    firewall = {
      allowedTCPPorts = [
        7830
        25565
      ];
      allowedUDPPorts = [
        7830
        25565
      ];
    };

  };

}
