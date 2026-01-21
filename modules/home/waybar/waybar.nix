{ pkgs, ... }:
{
  home.file.".config/waybar/style.css".source = ./waybar.css;
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 14;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = [
          "custom/appmenuicon"
          "sway/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "group/hardware"
          "pulseaudio"
          "network"
          "battery"
          "custom/power"
        ];
        spacing = 0;

        "sway/workspaces" = {
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
        "custom/system" = {
          format = " ";
          tooltip = false;
        };
        "group/hardware" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 300;
            children-class = "not-memory";
            transition-left-to-right = false;
            click-to-reveal = true;
          };
          modules = [
            "custom/system"
            "cpu"
            "memory"
            "temperature"
          ];
        };
        clock = {
          tooltip-format = "{calendar}";
          format-alt = "  {:%a, %d %b %Y}";
          format = "  {:%I:%M %p}";
        };
        cpu = {
          format = " ";
          format-alt = "  {usage}% ";
          interval = 2;
          on-click-right = "  {avg_frequency} GHz ";
        };
        memory = {
          format = " ";
          format-alt = "  {}% ";
          interval = 2;
          on-click-right = "  {used}GiB ";
        };
        temperature = {
          hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
          critical-threshold = 75;
          format = " ";
          format-alt = " {temperatureC}°C ";
          format-critical = " {temperatureC}°C ";
        };
        pulseaudio = {
          # scroll-step = 1; # %, can be a float
          format = "{icon}";
          format-alt = "{icon} {volume}%";
          #format-bluetooth = "{volume}% {icon} {format_source}";
          #format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "󰋋 ";
            hands-free = "󰋋 ";
            headset = "󰋋 ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [
              "󱝉 "
            ];
          };
          on-click-right = "pavucontrol";
        };
        network = {
          format = "{ifname}";
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = "⚠ ";
          tooltip-format = "   {ifname} via {gwaddri}";
          tooltip-format-wifi = ''
              {ifname} @ {essid}
            IP: {ipaddr}
            Strength: {signalStrength}%
            Freq: {frequency}MHz
            Up: {bandwidthUpBits} Down: {bandwidthDownBits}'';
          tooltip-format-ethernet = ''
              {ifname}
            IP: {ipaddr}
            up: {bandwidthUpBits} down: {bandwidthDownBits}'';
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          #on-click = "~/.config/ml4w/settings/networkmanager.sh";
          #on-click-right = "~/.config/ml4w/scripts/nm-applet.sh toggle";
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
          format-charging-alt = "";
          format-plugged = " ";
          format-plugged-alt = " {capacity}%";
          format-icons = [
            " "
            " "
            " "
            " "
            " "
          ];
        };
        "custom/power" = {
          format = "󰐥 ";
          on-click = "${pkgs.systemd}/bin/systemctl poweroff";
          on-click-right = "swaylock";
          tooltip-format = "Left: Power menu\nRight: Lock screen";
        };
      };
    };
  };
}
