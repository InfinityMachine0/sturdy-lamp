{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    wezterm = {
      enable = true;
    };
  };
}
