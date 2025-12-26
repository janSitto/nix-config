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
            level-name = "Comuna dos Manos";
            level-seed = "";
            enable-rcon = true;
            "rcon.port" = 25575;
            "rcon.password" = "placeholder";
        };
        dataDir = "/var/lib/minecraft";
        jvmOpts = "-Xms2048M -Xmx4096M";
    };
    systemd.services.minecraft-server. preStart = ''
        cp -f ${pkgs.runCommand "icon.png" { nativeBuildInputs = [ pkgs.imagemagick ]; } ''
            convert ${pkgs. fetchurl {
            url = "https://minecraft.wiki/images/Book_and_Quill_JE2_BE2.png";
            sha256 = "0a3yb9wkqhmanm4zwz2bpgdl2aa8x7gd44wajl3ijrk97d0h8n92";
            }} -resize 64x64! $out
        ''} /var/lib/minecraft/server-icon.png
    '';
}