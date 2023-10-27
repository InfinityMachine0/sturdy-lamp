{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    nushell = {
      enable = true;

      extraConfig = builtins.readFile (pkgs.fetchurl = {
        url = https://raw.githubusercontent.com/nushell/nu_scripts/main/themes/themes/catppuccin-mocha.nu;
        hash = "";
      });
    };
  };
}
