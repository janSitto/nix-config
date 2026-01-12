{ pkgs, ... }:
{

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;

    settings = {

      general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 0;
      };

      input = {
        kb_layout = "br,us";
        kb_variant = "abnt2";
        kb_options = "rctrl:nocaps,grp:ctrl_space_toggle";
      };

      "$mod" = "SUPER";
      "$act" = "ALT";

      bind = [

        # Abrir aplicativos
        "$mod, SPACE, exec, wofi"
        "$mod, A, exec, kitty yazi"
        "$mod, E, exec, kitty nvim"
        "$mod, F, exec, firefox"
        "$mod, Z, exec, zen-twilight"
        "$mod, T, exec, kitty"
        "$mod, O, exec, obsidian"
        "$mod, S, exec, steam"

        # Funcoes do sistema

        "$act, X, killactive,"
        "$act, F, fullscreen,"

        ", F3, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", F2, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", F1, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"

        ", F6, exec, brightnessctl set 10%-"
        ", F7, exec, brightnessctl set 10%+"

        ", F8, exec, hyprctl keyword monitor HDMI-A-1, 1920x1080@60, auto, 1, mirror, eDP-1"

        ", PRINT, exec, hyprshot -m region --clipboard-only"

        "$act, SPACE, exec, pgrep waybar && pkill waybar || waybar &"
        "$act, Tab, cyclenext,"
        "$act, W, movefocus, u"
        "$act, A, movefocus, l"
        "$act, S, movefocus, d"
        "$act, D, movefocus, r"
        "$act, Up, movewindow, u"
        "$act, Left, movewindow, l"
        "$act, Down, movewindow, d"
        "$act, Right, movewindow, r"
        "$act, I, resizeactive, 0 -100"
        "$act, J, resizeactive, -100 0"
        "$act, K, resizeactive, 0 100"
        "$act, L, resizeactive, 100 0"

        #Workspaces
        "$act, Z, togglespecialworkspace, magic"
        "$act, Z, movetoworkspace, +0"
        "$act, Z, togglespecialworkspace, magic"
        "$act, Z, movetoworkspace, special:magic"
        "$act, Z, togglespecialworkspace, magic"

        "$act, E, exec, hyprctl dispatch workspace e+1"
        "$act, Q, exec, hyprctl dispatch workspace e-1"
        "$act, 1, workspace, 1"
        "$act, 2, workspace, 2"
        "$act, 3, workspace, 3"
        "$act, 4, workspace, 4"
        "$act, 5, workspace, 5"
        "$act, 6, workspace, 6"
        "$act, 7, workspace, 7"
        "$act, 8, workspace, 8"
        "$act, 9, workspace, 9"
        "$act, 0, workspace, 0"
      ];
    };

    extraConfig = ''

          exec-once = obsidian
          exec-once = zen-twilight

          monitor = eDP-1, 1920x1080@120Hz, 0x0, 1.0
          monitor = HDMI-A-1, 1920x1080@60Hz, auto, 1.0
          #monitor = HDMI-A-1, 1920x1080@60Hz, 0x0, 1.0
      	  #monitor = HDMI-A-1, 1920x1080@60, auto, 1, mirror, eDP-1
          
    '';
  };

}
