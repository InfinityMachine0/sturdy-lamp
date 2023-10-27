{ inputs, lib, config, pkgs, ... }: 
{
  qt = {
    enable = true;

    platformTheme = "gtk";

    style = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sapphire" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };     
      name = "Catppuccin-Mocha-Compact-Sapphire";
    };
  };
}
