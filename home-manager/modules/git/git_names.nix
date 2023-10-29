{ inputs, lib, config, pkgs, ... }:
let
  GitName = "GIT_USERNAME_REPLACE";
  GitEmail = "GIT_EMAIL_REPLACE";
in 
{
  programs = { # configuring programs
    git = { # version control software
     userEmail = GitEmail; # set git email
     userName = GitName; # set git user name
    };
  };
}