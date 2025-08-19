{config, pkgs, lib, ...}: {

    # In order to the exit node to work you must enable forwarding
    # As it expects to be unique, it is in the server configuration.nix, not here
    # Look it up in ./hosts/server/configuration.nix if you got any doubts on how to do it

    services.tailscale = {
        enable = true;
        useRoutingFeatures = "both";
    };

    networking = {
        firewall = {
            trustedInterfaces = [ "tailscale0" ];
            allowedUDPPorts = [ 41641 ];
            extraCommands = ''
                iptables -I FORWARD -i tailscale0 -j ACCEPT
                ip6tables -I FORWARD -i tailscale0 -j ACCEPT
            '';
            extraStopCommands = ''
                iptables -D FORWARD -i tailscale0 -j ACCEPT || true
                ip6tables -D FORWARD -i tailscale0 -j ACCEPT || true
            '';
        };
        nat = {
            enable = true;
            internalInterfaces = [ "tailscale0" ];
        };
    };

}