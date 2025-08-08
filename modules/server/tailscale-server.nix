{pkgs, ...}: {
    services.tailscale = {
        enable = true;
        useRoutingFeatures = "both";
    };
    networking = {
        firewall = {
            trustedInterfaces = [ "tailscale0" ];
            allowForwardFrom = [ "tailscale0" ];
            allowedUDPPorts = [ 41641 ];
        };
        nat = {
            enable = true;
            internalInterfaces = [ "tailscale0" ];
        };
        sysctl = {
            "net.ipv4.ip_forward" = true;
            "net.ipv6.conf.all.forwarding" = true;
        };
    };
}