{ pkgs, ... }:
let

  lanInterface = "";
  vpnInterface = "";
  p2pInterface = "";
  lanDomain = "";
  vpnDomain = "";
  p2pDomain = "";
  ztrId = "";
  duckdnsToken = "";

in
{

  systemd.services.duckdns-update = {
    description = "Update DuckDNS IPs from specific interfaces";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = pkgs.writeShellScript "duckdns-updater" ''
              LAN_IP=$(${pkgs.iproute2}/bin/ip -4 -o addr show dev '${lanInterface}' | ${pkgs.gawk}/bin/awk '{print $4}' | cut -d/ -f1)
              VPN_IP=$(${pkgs.iproute2}/bin/ip -4 -o addr show dev '${vpnInterface}' | ${pkgs.gawk}/bin/awk '{print $4}' | cut -d/ -f1)
              P2P_IP=$(${pkgs.curl}/bin/curl -s -H "Authorization: Bearer $(cat /var/lib/zerotier-one/authtoken.secret)" \
        		 http://localhost:9993/network/${ztrId} | \
        		 ${pkgs.jq}/bin/jq -r '.assignedAddresses[]' | grep -Eo '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' | head -n1)

              ${pkgs.curl}/bin/curl -fsS \
                "https://www.duckdns.org/update?domains=${lanDomain}&token=${duckdnsToken}&ip=$LAN_IP" \
                > /dev/null

              ${pkgs.curl}/bin/curl -fsS \
                "https://www.duckdns.org/update?domains=${vpnDomain}&token=${duckdnsToken}&ip=$VPN_IP" \
                > /dev/null

              ${pkgs.curl}/bin/curl -fsS \
                "https://www.duckdns.org/update?domains=${p2pDomain}&token=${duckdnsToken}&ip=$P2P_IP" \
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

