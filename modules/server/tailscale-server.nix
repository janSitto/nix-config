{config, pkgs, lib, ...}: {
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
    boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
    };
}