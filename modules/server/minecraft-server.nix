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

    /*
        
        Template de instalação de plugins

        if [ ! -f /var/lib/minecraft/plugins/ ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/ \
            ""
        fi

    */

    environment.systemPackages = with pkgs; [ wget ];
    systemd.services.minecraft-server.preStart = ''
        cp -f ${pkgs.runCommand "icon.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
            convert ${pkgs.fetchurl {
            url = "https://minecraft.wiki/images/Book_and_Quill_JE2_BE2.png";
            sha256 = "0a3yb9wkqhmanm4zwz2bpgdl2aa8x7gd44wajl3ijrk97d0h8n92";
            }} -resize 64x64! $out
        ''} /var/lib/minecraft/server-icon.png

        mkdir -p /var/lib/minecraft/plugins

        # Admin plugins

        if [ ! -f /var/lib/minecraft/plugins/minimotd-paper-2.2.2.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/minimotd-paper-2.2.2.jar \
            "https://hangarcdn.papermc.io/plugins/jmp/MiniMOTD/versions/2.2.2/PAPER/minimotd-paper-2.2.2.jar"
        fi

        if [ ! -f /var/lib/minecraft/plugins/tabtps-paper-1.3.30.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/tabtps-paper-1.3.30.jar \
            "https://hangarcdn.papermc.io/plugins/jmp/TabTPS/versions/1.3.30/PAPER/tabtps-paper-1.3.30.jar"
        fi

        if [ ! -f /var/lib/minecraft/plugins/worldguard-bukkit-7.0.15-beta-01.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/worldguard-bukkit-7.0.15-beta-01.jar \
            "https://cdn.modrinth.com/data/DKY9btbd/versions/Cm1YG6Lt/worldguard-bukkit-7.0.15-beta-01.jar"
        fi

        if [ ! -f /var/lib/minecraft/plugins/ImageFrame-1.9.0.0.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/ImageFrame-1.9.0.0.jar \
            "https://hangarcdn.papermc.io/plugins/LOOHP/ImageFrame/versions/1.9.0/PAPER/ImageFrame-1.9.0.0.jar"
        fi

        if [ ! -f /var/lib/minecraft/plugins/Backuper-4.0.2.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/Backuper-4.0.2.jar \
            "https://cdn.modrinth.com/data/7cMAqMND/versions/zmX79wvI/Backuper-4.0.2.jar"
        fi

        # Anti-cheat plugins

        if [ ! -f /var/lib/minecraft/plugins/Orebfuscator.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/Orebfuscator.jar \
            "https://github.com/ImDaniX/Orebfuscator/releases/download/v5.4.1/Orebfuscator-5.4.1.jar"
        fi

        # Economy plugins

        if [ ! -f /var/lib/minecraft/plugins/JobListings-2.0.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/JobListings-2.0.jar \
            "https://hangarcdn.papermc.io/plugins/refractored/joblistings/versions/2.0/PAPER/JobListings-2.0.jar"
        fi


        # Miscellaneous plugins

        if [ ! -f /var/lib/minecraft/plugins/GSit-3.1.1.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/GSit-3.1.1.jar \
            "https://hangarcdn.papermc.io/plugins/Gecolay/GSit/versions/3.1.1/PAPER/GSit-3.1.1.jar"
        fi

        if [ ! -f /var/lib/minecraft/plugins/toolstats-1.9.11.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/toolstats-1.9.11.jar \
            "https://hangarcdn.papermc.io/plugins/hyperdefined/ToolStats/versions/1.9.11/PAPER/toolstats-1.9.11.jar"
        fi 

        if [ ! -f /var/lib/minecraft/plugins/voicechat-bukkit-2.6.7.jar ]; then
        ${pkgs.curl}/bin/curl -L -o /var/lib/minecraft/plugins/voicechat-bukkit-2.6.7.jar \
            "https://hangarcdn.papermc.io/plugins/henkelmax/SimpleVoiceChat/versions/bukkit-2.6.7/PAPER/voicechat-bukkit-2.6.7.jar"
        fi

    '';
     networking.firewall = {
        allowedTCPPorts = [];
        allowedUDPPorts = [ 24454 ]; #24454: voicechat;
    };
}
