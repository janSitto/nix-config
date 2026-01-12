{ config, pkgs, ... }:
{

  sops.secrets = {
    zerotier-id = {
      key = "zerotier/id";
    };
  };

  services.zerotierone.enable = true;

  systemd.services.zerotierone-secrets = {
    description = "ZeroTierOne with SOPS.";

    after = [ "zerotierone.service" ];
    requires = [ "zerotierone.service" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.zerotierone}/bin/zerotier-cli join $(cat ${config.sops.secrets.zerotier-id.path})'";
    };

    wantedBy = [ "multi-user.target" ];
  };

}

