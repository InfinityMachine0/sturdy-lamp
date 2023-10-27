{ inputs, lib, config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      (nerdfonts.override {fonts = [ "IosevkaTerm" "Iosevka"];})
      (iosevka-bin.override {variant = "sgr-iosevka-etoile";})
      (iosevka-bin.override {variant = "sgr-iosevka-aile";})
      (iosevka-bin.override {variant = "sgr-iosevka-term";})
      openmoji-color
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "Iosevka Etoile" ];
        sansSerif = [ "Iosevka Aile" ];
        monospace = [ "Iosevka Term Nerd Font" ];
        emoji = [ "OpenMoji Color" ];
      };
    };
  };
}