{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    xplr = {
      enable = true;
    };
  };
}

