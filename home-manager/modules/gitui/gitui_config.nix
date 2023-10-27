{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    gitui = { # git terminal ui
      enable = true; # enable gitui

      theme = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "gitui"; # Bat uses sublime syntax for its themes
        rev = "3c97c7af7247b1e0f4366a4d8fab650bcce54100";
        sha256 = "m6Tjch6A2ZPZ3/muvb/9sEAQUZfjnWqcwyhNVeqPS2c=";
      } + "/theme/mocha.ron";
    };
  };
}
