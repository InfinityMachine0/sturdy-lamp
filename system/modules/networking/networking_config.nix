{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./no_edit_hostname.nix
  ];
  ## networking settings
  networking = {
    # network manager as the networking tool
    networkmanager.enable = true; 
    };
  };
}