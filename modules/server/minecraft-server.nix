{config, pkgs, ...}: 
let
  serverIcon = pkgs.runCommand "server-icon.png" {
    nativeBuildInputs = [ pkgs.imagemagick ];
    src = pkgs.fetchurl {
      url = "https://minecraft.wiki/images/Book_and_Quill_JE2_BE2.png";
      sha256 = "0a3yb9wkqhmanm4zwz2bpgdl2aa8x7gd44wajl3ijrk97d0h8n92";
    };
  } ''
    convert $src -resize 64x64! $out
  '';
in
{
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
            level-seed = "Comuna dos Manos";
        };
        dataDir = "/var/lib/minecraft";
        jvmOpts = "-Xms2048M -Xmx4096M";
    };
    systemd.tmpfiles.rules = [
        "L+ /var/lib/minecraft/server-icon.png - - - - ${serverIcon}"
    ];
}