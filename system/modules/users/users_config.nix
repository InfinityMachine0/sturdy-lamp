{ inputs, lib, config, pkgs, ... }:
let
  NixUser = "USERNAME_REPLACE";
in 
{
  ## main user settings
  users.users.${NixUser} = {
    # is a "real" user
    isNormalUser = true; 

    # adding user groups
    extraGroups = [ "wheel" "networkmanager"]; 
      # wheel -> enable sudo
      # networkmanager -> enable networkmanager tool

    # setting the initial password
    initialPassword = "password"; 

    shell = pkgs.nushell;
  };
}