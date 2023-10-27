{ inputs, lib, config, pkgs, ... }: 
{
  imports = [
    ./no_edit_git_names.nix
  ];
  programs = { # configuring programs
    git = { # version control software
      enable = true; # enable git

     # userEmail = GitEmail; # set git email
     # userName = GitName; # set git user name
    };
  };
}