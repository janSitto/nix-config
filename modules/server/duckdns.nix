{ config, pkgs, ... }:
{

  # This is the encrypted version of duckdns.nix, if you want something simpler use duckdns-unsafe.nix
  # The only difference is that you declare the script variables in a let ... in statement instead of getting them from a safely encrypted .yaml file
  # Secret default directory declared in sops.nix

  sops.secrets = {
    duckdnsToken = {
      key = "duckdns/token";
    };
    lanDomain = {
      key = "duckdns/domain/lan";
    };
    p2pDomain = {
      key = "duckdns/domain/p2p";
    };
    vpnDomain = {
      key = "duckdns/domain/vpn";
    };
    lanInterface = {
      key = "device/server/interface/lan";
    };
    p2pInterface = {
      key = "device/server/interface/p2p";
    };
    vpnInterface = {
      key = "device/server/interface/vpn";
    };
    ztrId = {
      key = "zerotier/id";
    };
  };

  systemd.services.duckdns-update = {
    description = "Update DuckDNS IPs from specific interfaces";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      Requires = [
        "sops-secrets-duckdns.token.service"
        "sops-secrets-duckdns.domain.lan.service"
        "sops-secrets-duckdns.domain.p2p.service"
        "sops-secrets-duckdns.domain.vpn.service"
        "sops-secrets-duckdns.interface.lan.service"
        "sops-secrets-duckdns.interface.p2p.service"
        "sops-secrets-duckdns.interface.vpn.service"
        "sops-secrets-zerotier.id.service"
      ];
      Environment = [
        "duckdnsToken=$(cat ${config.sops.secrets.duckdnsToken.path})"
        "lanDomain=$(cat ${config.sops.secrets.lanDomain.path})"
        "p2pDomain=$(cat ${config.sops.secrets.p2pDomain.path})"
        "vpnDomain=$(cat ${config.sops.secrets.vpnDomain.path})"
        "lanInterface=$(cat ${config.sops.secrets.lanInterface.path})"
        "p2pInterface=$(cat ${config.sops.secrets.p2pInterface.path})"
        "vpnInterface=$(cat ${config.sops.secrets.vpnInterface.path})"
        "ztrId=$(cat ${config.sops.secrets.ztrId.path})"
      ];
      ExecStart = pkgs.writeShellScript "duckdns-updater" ''
              LAN_IP=$(${pkgs.iproute2}/bin/ip -4 -o addr show dev "$lanInterface" | ${pkgs.gawk}/bin/awk '{print $4}' | cut -d/ -f1)
              VPN_IP=$(${pkgs.iproute2}/bin/ip -4 -o addr show dev "$vpnInterface" | ${pkgs.gawk}/bin/awk '{print $4}' | cut -d/ -f1)
              P2P_IP=$(${pkgs.curl}/bin/curl -s -H "Authorization: Bearer $(cat /var/lib/zerotier-one/authtoken.secret)" \
        		 http://localhost:9993/network/"$ztrId" | \
        		 ${pkgs.jq}/bin/jq -r '.assignedAddresses[]' | grep -Eo '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n1)

              ${pkgs.curl}/bin/curl -fsS \
                "https://www.duckdns.org/update?domains=$lanDomain&token=$duckdnsToken&ip=$LAN_IP" \
                > /dev/null

              ${pkgs.curl}/bin/curl -fsS \
                "https://www.duckdns.org/update?domains=$vpnDomain&token=$duckdnsToken&ip=$VPN_IP" \
                > /dev/null

              ${pkgs.curl}/bin/curl -fsS \
                "https://www.duckdns.org/update?domains=$p2pDomain&token=$duckdnsToken&ip=$P2P_IP" \
                > /dev/null
      '';
      User = "root";
    };
  };

  systemd.timers.duckdns-update = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnUnitActiveSec = "5m";
      OnBootSec = "1m";
    };
  };

}

