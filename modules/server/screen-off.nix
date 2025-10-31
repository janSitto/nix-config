{pkgs, ...}: {
    systemd = {
        services.screen-off = {
            description = "Turn the screen off on server devices that have a fixed monitor.";
            serviceConfig = {
                Type = "oneshot";
                User = "root";
                ExecStart = pkgs.writeShellScript "screen-off" "echo 0 | tee /sys/class/backlight/*/brightness";
            };
        };
        timers.screen-off = {
            wantedBy = [ "timers.target" ];
            timerConfig.OnBootSec = "5m";
        };
    };
}