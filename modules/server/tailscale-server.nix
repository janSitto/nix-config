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
            externalInterface = lib.strings.stripString (builtins.readFile config.sops.secrets.lanInterface.path);
        };
    };
}