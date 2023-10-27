## hyprland configuration
{ inputs, lib, config, pkgs, ... }: 
{
  programs = {
    hyprland = {
      enable = true;
    };
  };
}