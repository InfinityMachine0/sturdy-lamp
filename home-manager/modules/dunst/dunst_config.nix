{ inputs, lib, config, pkgs, ... }: 
{
  services = {
    dunst = {
      enable = true;

      iconTheme = {
        package = pkgs.catppuccin-papirus-folders.override  {
          accent = "sapphire";
          flavor = "mocha";
        };
        name = "cat-mocha-sapphire";
      };

      settings = {
        global = {
          frame_color = "#1E66F5";
          separator_color = "#1E66F5";
        };
        
        urgency_low = {
          background = "#EFF1F5";
          foreground = "#4C4F69";
        };
        
        urgency_normal = {
          background = "#EFF1F5";
          foreground = "#4C4F69";
        };
        
        urgency_critical = {
          background = "#EFF1F5";
          foreground = "#4C4F69";
          frame_color = "#FE640B";
        };
      };
    };
  };
}
