{pkgs, username, ...}: {
    services = {
        samba = {
            enable = true;
                winbindd.enable = false;
                nmbd.enable = true;
                openFirewall = true;
                settings = {
                global = {
                    "log level" = "3";
                    workgroup = "WORKGROUP";
                };
                #logging = systemd;
                global.security = "user";
                "${username}-private" = {
                    path = "/data/samba/${username}";
                    "valid users" = [ "${username}" ];
                    writable = true;
                    "create mask" = "0700";
                    "directory mask" = "0700";
                    "force user" = "${username}";
                    "force group" = "users";
                };
            };
        };
        samba-wsdd = {
            enable = true;
            openFirewall = true;
        };
    };
    systemd.tmpfiles.rules = [
        "d /var/lib/samba 0755 root root - -"
        "d /var/lib/samba/private 0700 root root - -"
        "z /var/lib/samba/private/msg.sock 0700 root root - -"
        "d /var/lib/samba/private/msg.sock 0700 root root - -"
        "d /var/lib/samba 0755 root root - -"
        "d /var/run/samba 0700 root root - -"
        "d /var/cache/samba 0755 root root - -"
        "d /run/samba 0700 root root - -"
        "d /data/samba 0755 root root - -"
        "d /data/samba/${username} 0700 ${username} users - -"
    ];
}
