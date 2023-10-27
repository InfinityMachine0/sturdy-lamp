{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          modules-left = ["hyprland/workspaces" "hyprland/submap"];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "battery" "clock" ];

          "battery" = {
            format = "{capacity}% {icon}";
            "format-icons" = [ "!" "@" "#" "$" "%" ];
          };

          "clock" = {
            format-alt = "{:%a, %d. %b  %H:%M}";
          };
        };
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        extraConfig = ''
          exec-once = waybar
        '';
      };
    };
  };
}
