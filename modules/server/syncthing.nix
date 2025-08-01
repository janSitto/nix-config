{pkgs, username, ...}: {

    networking = { 
        firewall.allowedTCPPorts = [ 8384 22000 ];
        firewall.allowedUDPPorts = [ 22000 21027 ];
    };

    services.syncthing = {
        enable = true;
        group = "users";
        user = "${username}";
        dataDir = "/home/${username}/Documents";
        configDir = "/home/${username}/.config/syncthing";
        overrideDevices = true;     # overrides any devices added or deleted through the WebUI
        overrideFolders = true;     # overrides any folders added or deleted through the WebUI
        settings = {
            devices = {
                "nixos" = { id = "7GU3YVI-3HS4JIG-WYGPVFK-HL6BZJZ-JYNMNW6-7MHDKGT-VZYWC5U-D6G4OA2"; };
                "nixos-server" = { id = "OBCAOYX-7HFXDTY-KS7C4U4-CSLHE2Y-XJZ26N7-AO57C2M-JAHTMAC-YN7RIA5"; };
                "phone" = { id = "FVFZWJJ-3GS722X-VMQUZQE-5KXCGJR-DNJD3NH-BYIYH6K-GEOTPKG-VZBO5QV"; };
            };
            folders = {
                "Documents" = {         # Name of folder in Syncthing, also the folder ID
                    path = "/home/${username}/Documents";    # Which folder to add to Syncthing
                    devices = [ "nixos" "nixos-server" "phone" ];      # Which devices to share the folder with
                };
            };
            gui = {
                user = "${username}";
                password = "password";
            };
        };
    };

    systemd.tmpfiles.rules = [
        "d /home/${username}/.config 0755 ${username} users -"
        "d /home/${username}/.config/syncthing 0755 ${username} users -"
    ];

}