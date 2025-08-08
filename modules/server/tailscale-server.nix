{pkgs, ...}: {
    services.tailscale = {
        enable = true;
        useRoutingFeatures = "both"
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
            externalInterface = config.networking.defaultGatewayInterface;
        };
        sysctl = {
            "net.ipv4.ip_forward" = true;
            "net.ipv6.conf.all.forwarding" = true;
        };
    };
}