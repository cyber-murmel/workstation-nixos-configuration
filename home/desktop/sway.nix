{ pkgs, ... }:
{
  home = {
    keyboard.layout = "us";

    sessionVariables = {
      XDG_CURRENT_DESKTOP = "sway";
      XDG_SESSION_TYPE = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };

  wayland.windowManager.sway = {
    enable = true;
    config = {
      # keyboard/mouse/touchpad
      input = {
        "*" = {
          xkb_layout = "us";
          xkb_variant = "altgr-intl";
        };
      };

      # monitor
      output = {
        "*" = {
          # background = "$HOME/wallpaper.jpg fill";
          scale = "1.0";
        };
      };

      keybindings = let
        mod = "Mod4";
        inherit (pkgs) brightnessctl mako playerctl ponymix wofi;
      in
      {
        "${mod}+Shift+r" = "reload";
        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "${mod}+v" = "split v";
        "${mod}+h" = "split h";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+r" = "mode resize";

        "${mod}+f" = "fullscreen toggle";
        "${mod}+Shift+space" = "floating toggle";

        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";

        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";

        "${mod}+Return" = "exec foot";
        "${mod}+Shift+Return" = "exec firefox";
        "${mod}+Space" = "exec ${mako}/bin/makoctl dismiss";
        "${mod}+d" = "exec ${wofi}/bin/wofi --show drun";

        # brightness
        XF86MonBrightnessDown = "exec ${brightnessctl}/bin/brightnessctl -q s 5%-";
        XF86MonBrightnessUp = "exec ${brightnessctl}/bin/brightnessctl -q s 5%+";

        # volume
        XF86AudioRaiseVolume = "exec ${ponymix}/bin/ponymix increase 5";
        XF86AudioLowerVolume = "exec ${ponymix}/bin/ponymix decrease 5";
        XF86AudioMute = "exec ${ponymix}/bin/ponymix toggle";

        # media
        XF86AudioPlay = "exec ${playerctl}/bin/playerctl play-pause";
        XF86AudioPause = "exec ${playerctl}/bin/playerctl pause";
        XF86AudioNext = "exec ${playerctl}/bin/playerctl next";
        XF86AudioPrev = "exec ${playerctl}/bin/playerctl previous";
      };

      # allow toggling between workspaces
      workspaceAutoBackAndForth = true;

      # enable gaps between windows
      gaps = {
        inner = 12;
      };

      # application/window specific settings
      window = {
        commands = let
          inhibitFullScreenIdle = criteria: {
            inherit criteria;
            command = "inhibit_idle fullscreen";
          };
        in
        # prevent screen blanking for these apps
        (map inhibitFullScreenIdle [ {
          class = "mpv";
        } {
          app_id = "firefox";
        }]);
      };
    };
  };
}
