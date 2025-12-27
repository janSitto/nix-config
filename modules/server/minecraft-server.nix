{config, pkgs, ...}: {
    services.minecraft-server = {
        enable = true;
        eula = true;
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
            motd = "Servidor NixOS de JVS";
            white-list = false;
            allow-cheats = false;
            enforce-secure-profile = false;
            force-gamemode = true;
            view-distance = 12;
            level-name = "Comuna dos Manos";
            level-seed = "";
        };
        package = pkgs.papermc;
        dataDir = "/var/lib/minecraft";
        jvmOpts = "-Xms2048M -Xmx4096M";
    };
    environment.systemPackages = with pkgs; [ screen ];
    systemd.sockets.minecraft-server = {
        enable = false;
        antedBy = pkgs.lib.mkForce [];
    };
    systemd.services.minecraft-server = {
        requires = pkgs.lib.mkForce [];
        after = pkgs.lib.mkForce [ "network.target" ];
        wantedBy = [ "multi-user.target" ]; 
        
        serviceConfig = {
            Type = pkgs.lib.mkForce "forking";
            ExecStart = pkgs.lib. mkForce ''
                ${pkgs.screen}/bin/screen -DmS minecraft ${pkgs. bash}/bin/bash -c "cd /var/lib/minecraft && ${pkgs.jdk17}/bin/java ${config.services. minecraft-server.jvmOpts} -jar ${pkgs. papermc}/lib/papermc/papermc.jar nogui"
            '';
            ExecStop = pkgs.lib. mkForce ''
                ${pkgs.screen}/bin/screen -S minecraft -X stuff 'stop^M'
            '';
        };

        preStart = ''
            cp -f ${pkgs.runCommand "icon.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
                convert ${pkgs. fetchurl {
                url = "https://minecraft.wiki/images/Book_and_Quill_JE2_BE2.png";
                sha256 = "0a3yb9wkqhmanm4zwz2bpgdl2aa8x7gd44wajl3ijrk97d0h8n92";
                }} -resize 64x64! $out
            ''} /var/lib/minecraft/server-icon.png
        '';
    };
}