{ inputs, lib, config, pkgs, ... }:
{
  ## services configuration
  services = { 
    printing.enable = true; 
  };
}