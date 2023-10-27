{ inputs, lib, config, pkgs, ... }:
let
  NixUser = USERNAME_REPLACE;
in 
{
  home = {
    username = NixUser; # user name
    homeDirectory = "/home/" + NixUser; # path to users home
  };
}
