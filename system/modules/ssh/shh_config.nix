{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./no_edit_ssh_ports.nix
  ];
  ## services configuration
  services = { 
  ## ssh settings
    openssh = { 
      # enable ssh
      enable = true; 
    };
  };
}