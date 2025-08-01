{pkgs, ...}: {
    services.tailscale.enable = true;
    networking.firewall.trustedInterfaces = [ "tailscale0" ];
    networking.nat = {
      enable = true;
      internalInterfaces = [ "tailscale0" ];
    };
}