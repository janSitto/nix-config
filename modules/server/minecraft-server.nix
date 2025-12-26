{config, pkgs, ...}: {
    services.minecraft-server = {
        enable = true;
        eula = true;
        package = pkgs.minecraft-server.overrideAttrs (old: rec {
            version = "1.21.11"; 
            nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.makeWrapper ];
            src = pkgs.fetchurl {
                url = "https://piston-data.mojang.com/v1/objects/64bb6d763bed0a9f1d632ec347938594144943ed/server.jar"; 
                sha256 = "sha256-+DuOCThlgG+THH40quQbF31MB2M1Jj3RJMddbWXdFyY="; 
            };
            installPhase = ''
                mkdir -p $out/bin $out/lib/minecraft
                cp $src $out/lib/minecraft/server.jar
                makeWrapper ${pkgs.openjdk21}/bin/java $out/bin/minecraft-server \
                    --add-flags "-jar $out/lib/minecraft/server.jar"
            '';

        });
        jvmOpts = "-Xms2048M -Xmx4096M";
        openFirewall = true; 
        declarative = true;
        whitelist = {
            # This is a mapping from Minecraft usernames to UUIDs. You can use https://mcuuid.net/ to get a Minecraft UUID for a username
            #username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
            #username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
        };
        serverProperties = {
            server-port = 25565;
            difficulty = 3;
            gamemode = 0;
            max-players = 10;
            motd = "Comuna dos Manos";
            white-list = false;
            allow-cheats = false;
            enforce-secure-profile = false;
            force-gamemode = true;
            level-name = "Comuna dos Manos";
            level-seed = "Comuna dos Manos";
        };
    };
    networking = { 
        firewall.allowedTCPPorts = [ 25565 ];
        firewall.allowedUDPPorts = [ 25565 ];
    };
}