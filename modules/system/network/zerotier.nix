{ config, pkgs, ... }: {

  sops.secrets = {
    zerotier-id = { key = "zerotier/id"; };
  };

  services.zerotierone.enable = false;

  systemd.services.zerotierone-secrets = {
    description = "ZeroTier One Network Manager with SOPS secrets";

    after = [ "zerotierone.service" ];
    requires = [ "zerotierone.service" ];
    
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.zerotierone}/bin/zerotier-cli join $(cat ${config.sops.secrets.zerotier-id.path})";
    };

    wantedBy = [ "multi-user.target" ];
  };
  
}