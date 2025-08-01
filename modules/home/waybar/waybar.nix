{ pkgs, ... }:
{
  home.file.".config/waybar/style.css".source = ./waybar.css;
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "graphical-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 21;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [
          "custom/appmenuicon"
          "hyprland/workspaces"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "cpu"
          "memory"
          "temperature"
          "pulseaudio"
          "network"
          "battery"
          "custom/power"
        ];
        spacing = 5;

        "hyprland/workspaces" = {
          active-only = false;
          disable-scroll = true;
          on-click = "activate";
          persistent-workspaces = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
          };
        };
        "custom/appmenu" = {
          format = "Apps";
          on-click = "sleep 0.2; pkill wofi || wofi --show drun";
          tooltip = false;
        };

        "custom/appmenuicon" = {
          format = " ";
          on-click = "pkill wofi || wofi --show drun";
          tooltip = false;
        };
        clock = {
          format = "{:%d.%m.%Y | %H:%M}";
        };
        cpu = {
          format = " ";
          format-alt = "  {usage}%";
          interval = 2;
          on-click-right = "  {avg_frequency} GHz";
        };
        memory = {
          format = " ";
          format-alt = "  {}%";
          interval = 2;
          on-click-right = "  {used}GiB";
        };
        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
          critical-threshold = 75;
          format = "";
          format-alt = " {temperatureC}°C";
          format-critical = " {temperatureC}°C";
        };
        pulseaudio = {
          format = "{icon}";
          format-alt = "{icon} {volume}%";
          format-bluetooth = "{icon} {format_source}";
          format-bluetooth-alt = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "";
          format-source-muted = " ";
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [
              " "
              " "
              " "
            ];
          };
        };
        network = {
          format = "{ifname}";
          format-wifi = " ";
          format-ethernet = "󰈀 ";
          format-disconnected = "Disconnected";
          tooltip-format-wifi = ''
            	    {ifname} @ {essid}
            	  IP: {ipaddr}
            	  Strength: {signalStrength}%
            	  Freq: {frequency}MHz
            	  Up: {bandwidthUpBits} Down: {bandwidthDownBits}'';
          tooltip-format-ethernet = ''
                  󰈀 : {ifname}
            	  IP: {ipaddr}
             	  up: {bandwidthUpBits} down: {bandwidthDownBits}'';
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "  {signalStrength}%";
        };
        battery = {
          state = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-alt = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          #format-charging-alt = "";
          format-plugged = " {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
        };
        "custom/power" = {
          format = "󰐥";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
          tooltip = false;
        };
      };
    };
  };
}
