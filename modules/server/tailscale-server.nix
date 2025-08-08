{config, pkgs, lib, ...}: {
    sops.secrets.lanInterface = { key = "device/server/interface/lan"; };
    services.tailscale = {
        enable = true;
        useRoutingFeatures = "both";
    };
    networking = {
        firewall = {
            trustedInterfaces = [ "tailscale0" ];
            allowedUDPPorts = [ 41641 ];
            extraCommands = ''
                iptables -A nixos-fw-forward -i tailscale0 -j ACCEPT
                ip6tables -A nixos-fw-forward -i tailscale0 -j ACCEPT
            '';
        };
        nat = {
            enable = true;
            internalInterfaces = [ "tailscale0" ];
        };
    };
    systemd.services.nat-tailscale = {
        description = "Setup tailscale NAT using secrets"; 
        after = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];
        requires = [ "sops-secrets-device.server.interface.lan.path.service" ];
        serviceConfig = {
            Type = "oneshot";
            Environment = [
                "lanInterface=$(cat ${config.sops.secrets.lanInterface.path})"
            ];
            ExecStart = pkgs.writeShellScript "nat-tailscale" ''
                ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -o "$lanInterface" -j MASQUERADE
            '';
        };
    };
}