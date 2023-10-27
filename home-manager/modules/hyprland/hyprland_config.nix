{ inputs, lib, config, pkgs, ... }: 
{
  # You can import other home-manager modules here
  imports = [
    ./hyprland_gpu_patch.nix
    ./hyprland_platform_patch.nix
  ];

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;

        # monitor = ${DisplayName},${Resolution}@${RefreshRate},0x0,1
        # exec-once = swaybg -i ../../wallpapers/42.jpg -m fit
        # monitor = ,preferred,0x0,1
        # extraConfig = ''
        #   monitor=Virtual-1, 1920x1080, 0x0, 1
        # '';

        settings = {
          general = {
            layout = "master";
          };

          decoration = {
            rounding = "3";
          };

          "$main_mod" = "SUPER";

          bind = [
            "$main_mod, q, exec, foot"
            "$main_mod, x, killactive"
            "$main_mod, w, exec, rofi"
            "$main_mod, e, fullscreen"

            "$main_mod, bracketleft, workspace, e-1"
            "$main_mod, bracketright, workspace, e+1"

            "$main_mod, mouse_down, workspace, e-1"
            "$main_mod, mouse_up, workspace, e+1"

            "$main_mod, h, movefocus, l"
            "$main_mod, l, movefocus, r"
            "$main_mod, k, movefocus, u"
            "$main_mod, j, movefocus, d"

            "$main_mod, left, movefocus, l"
            "$main_mod, right, movefocus, r"
            "$main_mod, up, movefocus, u"
            "$main_mod, down, movefocus, d"

            "$main_mod SHIFT, h, resizeactive, -10 0"
            "$main_mod SHIFT, l, resizeactive, 10 0"
            "$main_mod SHIFT, k, resizeactive, 0 -10"
            "$main_mod SHIFT, j, resizeactive, 0 10"

            "$main_mod SHIFT, left, resizeactive, -10 0"
            "$main_mod SHIFT, right, resizeactive, 10 0"
            "$main_mod SHIFT, up, resizeactive, 0 -10"
            "$main_mod SHIFT, down, resizeactive, 0 10"

            "$main_mod grave, h, swapwindow, l"
            "$main_mod grave, l, swapwindow, r"
            "$main_mod grave, k, swapwindow, u"
            "$main_mod grave, j, swapwindow, d"

            "$main_mod grave, left, swapwindow, l"
            "$main_mod grave, right, swapwindow, r"
            "$main_mod grave, up, swapwindow, u"
            "$main_mod grave, down, swapwindow, d"

            "$main_mod, 1, workspace, 1"
            "$main_mod, 2, workspace, 2"
            "$main_mod, 3, workspace, 3"
            "$main_mod, 4, workspace, 4"
            "$main_mod, 5, workspace, 5"
            "$main_mod, 6, workspace, 6"
            "$main_mod, 7, workspace, 7"
            "$main_mod, 8, workspace, 8"
            "$main_mod, 9, workspace, 9"
            "$main_mod, 0, workspace, 10"

            "$main_mod SHIFT, 1, movetoworkspace, 1"
            "$main_mod SHIFT, 2, movetoworkspace, 2"
            "$main_mod SHIFT, 3, movetoworkspace, 3"
            "$main_mod SHIFT, 4, movetoworkspace, 4"
            "$main_mod SHIFT, 5, movetoworkspace, 5"
            "$main_mod SHIFT, 6, movetoworkspace, 6"
            "$main_mod SHIFT, 7, movetoworkspace, 7"
            "$main_mod SHIFT, 8, movetoworkspace, 8"
            "$main_mod SHIFT, 9, movetoworkspace, 9"
            "$main_mod SHIFT, 0, movetoworkspace, 10"
          ];

          bindm = [
            "$main_mod, mouse:272, movewindow"
            "$main_mod, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}