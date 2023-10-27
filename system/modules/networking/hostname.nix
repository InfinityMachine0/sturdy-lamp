{ inputs, lib, config, pkgs, ... }:
let
  NixHost = HOSTNAME_REPLACE;
in 
{
  ## networking settings
  networking = {
    # setting host name for networking
    hostName = NixHost; 
  };
}