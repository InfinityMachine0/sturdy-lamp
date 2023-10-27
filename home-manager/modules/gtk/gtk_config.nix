{ inputs, lib, config, pkgs, ... }: 
{
  home = {
    pointerCursor = { # cursor settings
      package = pkgs.catppuccin-cursors.mochaDark; # cursor package
      name = "Catppuccin-Mocha-Dark-Cursors"; # cursor to use
      gtk.enable = true; # gtk support
    };
  };

  gtk = {
    enable = true;

    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "sapphire" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };     
      name = "Catppuccin-Mocha-Compact-Sapphire";
    };

    font = {
      package = pkgs.iosevka-bin.override {variant = "sgr-iosevka-aile";};
      name = "Iosevka Aile";
      size = 8;
    };

    iconTheme = {
      package = pkgs.catppuccin-papirus-folders.override  {
        accent = "sapphire";
        flavor = "mocha";
      };
      name = "cat-mocha-sapphire";
    };
  };
}
