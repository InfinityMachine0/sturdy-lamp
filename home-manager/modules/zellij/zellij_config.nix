{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    zellij = {
      enable = true;
    };
  };
}


