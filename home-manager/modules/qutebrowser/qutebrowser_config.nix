{ inputs, lib, config, pkgs, ... }: 
{
  home = {
    packages = with pkgs; [ # user packages
      python311Packages.adblock
    ];
  };

  xdg = {
    configFile = {
    "qutebrowser/catppuccin/__init__.py".source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "qutebrowser";
        rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
        sha256 = "lp7HWYuD4aUyX1nRipldEojZVIvQmsxjYATdyHWph0g=";
      } + "/__init__.py";

      "qutebrowser/catppuccin/setup.py".source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "qutebrowser";
        rev = "78bb72b4c60b421c8ea64dd7c960add6add92f83";
        sha256 = "lp7HWYuD4aUyX1nRipldEojZVIvQmsxjYATdyHWph0g=";
      } + "/setup.py";
    };
  };

  programs = { # configuring programs
    qutebrowser = {
      enable = true;

      extraConfig = ''
        import catppuccin

        # load your autoconfig, use this, if the rest of your config is empty!
        config.load_autoconfig()
        
        # set the flavor you'd like to use
        # valid options are 'mocha', 'macchiato', 'frappe', and 'latte'
        # last argument (optional, default is False): enable the plain look for the menu rows
        catppuccin.setup(c, 'mocha', True)
      '';
    };
  };
}
