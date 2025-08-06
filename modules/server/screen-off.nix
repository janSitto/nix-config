{pkgs, ...}: {
    systemd = {
        services.screen-off = {
            serviceConfig = {
                description = "Turn the screen off on server devices that has a fixed monitor.";
                Type = "oneshot";
                User = "root";
                ExecStart = pkgs.writeShellScript "screen-off" "echo 0 | sudo tee /sys/class/backlight/*/brightness";
            };
        };
        timers.scren-off = {
            wantedBy = [ "timers.target" ];
            timerConfig.OnBootSec = "5m";
        };
    };
}