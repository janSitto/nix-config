{
  config,
  pkgs,
  username,
  ...
}:
{

  sops.secrets.vpnDomain = {
    key = "duckdns/domain/vpn";
  };

  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
    };

    nameservers = [
      "1.1.1.1"
      "8.8.8.8"
    ];

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
