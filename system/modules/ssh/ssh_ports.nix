{ inputs, lib, config, pkgs, ... }:
{
  ## services configuration
  services = { 
  ## ssh settings
    openssh = { 
      # set the ssh port
      ports = SSHPORTS_REPLACE; 
    };
  };
}