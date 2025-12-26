{config, pkgs, ...}: {
    services.minecraft-server = {
        enable = true;
        eula = true;
        package = pkgs.minecraft-server.overrideAttrs (old: rec {
            version = "1.21.11"; 
            src = pkgs.fetchurl {
                url = "https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar"; 
                sha256 = "0mzjjgf2b2k4iam885jqicam540v646dwvy06d0dxyqay3586kni"; 
            };
        });
        openFirewall = true; 
        declarative = true;
        whitelist = {
            # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
            #username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
            #username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
        };
        serverProperties = {
            server-port = 25565;
            difficulty = "hard";
            gamemode = "survival";
            max-players = 10;
            motd = "Comuna dos Manos";
            white-list = false;
            allow-cheats = false;
            enforce-secure-profile = false;
            force-gamemode = true;
            level-name = "Comuna dos Manos";
            level-seed = "Comuna dos Manos";
        };
        jvmOpts = "-Xms2048M -Xmx4096M";
    };
    networking = { 
        firewall.allowedTCPPorts = [ 25565 ];
        firewall.allowedUDPPorts = [ 25565 ];
    };
}