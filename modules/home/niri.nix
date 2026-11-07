{local, ...}: {
  programs.niri.settings = {
    # Stylix owns colors and cursor

    # #################################################
    # General
    # https://github.com/niri-wm/niri/wiki/Configuration:-Miscellaneous
    # #################################################

    debug.honor-xdg-activation-with-invalid-serial = true;

    # Noctalia takes screenshots
    screenshot-path = null;

    # #################################################
    # Startup
    # https://github.com/niri-wm/niri/wiki/Configuration:-Miscellaneous#spawn-at-startup
    # #################################################

    # One process, no shell:
    # spawn-at-startup = [ { argv = [ "app" "--flag" ]; } ];
    # Through sh for pipes and variables:
    # spawn-at-startup = [ { sh = "app1 & app2"; } ];

    # #################################################
    # Outputs
    # https://github.com/niri-wm/niri/wiki/Configuration:-Outputs
    # #################################################

    # Per machine outputs come from local.nix
    outputs = local.outputs or {};

    # #################################################
    # Input
    # https://github.com/niri-wm/niri/wiki/Configuration:-Input
    # #################################################

    input = {
      keyboard.xkb = {
        layout = local.keyboardLayouts;
        options = local.keyboardOptions;
      };

      # Track layout per window
      keyboard.track-layout = "window";

      touchpad = {
        natural-scroll = true;
        dwt = true; # Ignore while typing
      };

      mouse = {
        accel-profile = "flat";
        natural-scroll = true; # Match the touchpad
      };

      focus-follows-mouse.enable = true;
    };

    # #################################################
    # Layout
    # https://github.com/niri-wm/niri/wiki/Configuration:-Layout
    # #################################################

    layout = {
      gaps = 12;
      center-focused-column = "on-overflow";

      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];
      default-column-width.proportion = 1.0 / 2.0;

      # Stylix sets a border, force a ring instead
      focus-ring = {
        enable = true;
        width = 2;
        active.color = "#dcd7ba";
        inactive.color = "#00000000";
      };

      border.enable = false;
    };

    # #################################################
    # Rules
    # https://github.com/niri-wm/niri/wiki/Configuration:-Window-Rules
    # #################################################

    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 16.0;
          top-right = 16.0;
          bottom-left = 16.0;
          bottom-right = 16.0;
        };
        clip-to-geometry = true;
      }

      {
        matches = [
          {
            app-id = "zen(-beta)?$";
            title = "^Picture-in-Picture$";
          }
        ];
        open-floating = true;
      }

      {
        matches = [{app-id = "dev.noctalia.Noctalia";}];
        open-floating = true;
        default-column-width = {fixed = 1080;};
        default-window-height = {fixed = 920;};
      }
    ];

    # #################################################
    # Layer rules
    # https://github.com/niri-wm/niri/wiki/Configuration:-Layer-Rules
    # #################################################

    # Namespaces come from niri msg layers
    # layer-rules = [
    #   {
    #     matches = [ { namespace = "^namespace$"; } ];
    #     shadow = { enable = false; };
    #   }
    # ];

    layer-rules = [
      {
        matches = [{namespace = "^noctalia-backdrop$";}];
        place-within-backdrop = true;
      }
    ];

    # #################################################
    # Animations
    # https://github.com/niri-wm/niri/wiki/Configuration:-Animations
    # #################################################

    animations = {
      workspace-switch = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.65;
          stiffness = 500;
          epsilon = 0.0001;
        };
      };

      window-open = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.55;
          stiffness = 600;
          epsilon = 0.0001;
        };
      };

      window-close = {
        enable = true;
        kind.easing = {
          duration-ms = 150;
          curve = "ease-out-quad";
        };
      };

      horizontal-view-movement = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.65;
          stiffness = 500;
          epsilon = 0.0001;
        };
      };

      window-movement = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.65;
          stiffness = 500;
          epsilon = 0.0001;
        };
      };

      window-resize = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.65;
          stiffness = 500;
          epsilon = 0.0001;
        };

        custom-shader = ''
          vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
            vec3 coords_tex_next = niri_geo_to_tex_next * coords_curr_geo;
            vec4 color = texture2D(niri_tex_next, coords_tex_next.st);
            return color;
          }
        '';
      };

      config-notification-open-close = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.65;
          stiffness = 700;
          epsilon = 0.001;
        };
      };

      screenshot-ui-open = {
        enable = true;
        kind.easing = {
          duration-ms = 200;
          curve = "ease-out-quad";
        };
      };

      overview-open-close = {
        enable = true;
        kind.spring = {
          damping-ratio = 0.75;
          stiffness = 400;
          epsilon = 0.0003;
        };
      };
    };

    # #################################################
    # Binds
    # https://github.com/niri-wm/niri/wiki/Configuration:-Key-Bindings
    # #################################################

    # Format: "Mod+Shift+Key".action.<action> = args
    # Modifiers: Ctrl, Shift, Alt, Mod
    # List actions with niri msg action <name> --help

    binds = {
      # General
      "Mod+Shift+Slash".action.show-hotkey-overlay = {};
      "Mod+Shift+E".action.quit = {};
      "Print".action.spawn = ["noctalia" "msg" "screenshot-region"];

      # Applications
      "Mod+Return".action.spawn = "kitty";
      # The Noctalia launcher is a named panel
      "Mod+Space".action.spawn = [
        "noctalia"
        "msg"
        "panel-toggle"
        "launcher"
      ];
      "Mod+B".action.spawn = "zen-beta";
      "Mod+E".action.spawn = "nautilus";

      # Windows
      "Mod+Q".action.close-window = {};

      "Mod+Left".action.focus-column-left = {};
      "Mod+Right".action.focus-column-right = {};
      "Mod+Up".action.focus-window-up = {};
      "Mod+Down".action.focus-window-down = {};

      "Mod+Shift+Left".action.move-column-left = {};
      "Mod+Shift+Right".action.move-column-right = {};
      "Mod+Shift+Down".action.move-window-down = {};
      "Mod+Shift+Up".action.move-window-up = {};

      "Mod+Minus".action.set-column-width = "-10%";
      "Mod+Equal".action.set-column-width = "+10%";
      "Mod+Shift+Minus".action.set-window-height = "-10%";
      "Mod+Shift+Equal".action.set-window-height = "+10%";

      "Mod+F".action.maximize-column = {};
      "Mod+Shift+F".action.fullscreen-window = {};

      "Mod+V".action.toggle-window-floating = {};
      "Mod+W".action.toggle-column-tabbed-display = {};
      "Mod+R".action.switch-preset-column-width = {};
      "Mod+BracketLeft".action.consume-or-expel-window-left = {};
      "Mod+BracketRight".action.consume-or-expel-window-right = {};
      "Mod+Comma".action.consume-window-into-column = {};
      "Mod+Period".action.expel-window-from-column = {};

      "Mod+Tab".action.spawn = ["noctalia" "msg" "window-switcher" "hold"];

      # Workspaces
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;

      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;

      # Media
      "XF86AudioRaiseVolume" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" "-l" "1.0"];
      };
      "XF86AudioLowerVolume" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" "-l" "1.0"];
      };
      "XF86AudioMute" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
      };
      "XF86AudioMicMute" = {
        allow-when-locked = true;
        action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
      };

      "XF86AudioPlay" = {
        allow-when-locked = true;
        action.spawn = ["playerctl" "play-pause"];
      };
      "XF86AudioPause" = {
        allow-when-locked = true;
        action.spawn = ["playerctl" "play-pause"];
      };
      "XF86AudioStop" = {
        allow-when-locked = true;
        action.spawn = ["playerctl" "stop"];
      };
      "XF86AudioPrev" = {
        allow-when-locked = true;
        action.spawn = ["playerctl" "previous"];
      };
      "XF86AudioNext" = {
        allow-when-locked = true;
        action.spawn = ["playerctl" "next"];
      };

      "XF86MonBrightnessUp" = {
        allow-when-locked = true;
        action.spawn = ["brightnessctl" "set" "+10%"];
      };
      "XF86MonBrightnessDown" = {
        allow-when-locked = true;
        action.spawn = ["brightnessctl" "set" "-10%"];
      };
    };
  };
}
