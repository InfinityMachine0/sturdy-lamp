{ inputs, lib, config, pkgs, ... }: 
{
    # You can import other home-manager modules here
  imports = [
    ./modules/rofi/rofi_config.nix
    
    ./modules/waybar/waybar_config.nix
    
    ./modules/bat/bat_config.nix
    
    ./modules/bottom/bottom_config.nix
    
    ./modules/dunst/dunst_config.nix
    
    ./modules/foor/foor_config.nix
    
    ./modules/fzf/fzf_config.nix

    ./modules/git/git_config.nix

    ./modules/gitui/gitui_config.nix
    
    ./modules/gtk/gtk_config.nix

    ./modules/home-path/no_edit_home-path_config.nix

    ./modules/nixvim/nixvim_config.nix

    ./modules/nushell/nushell_config.nix

    ./modules/qt/qt_config.nix

    ./modules/qutebrowser/qutebrowser_config.nix

    ./modules/starship/starship_config.nix

    ./modules/wezterm/wezterm_config.nix

    ./modules/hyprland/hyprland_config.nix

    ./modules/xplr/xplr_config.nix

    ./modules/zellij/zellij_config.nix
  ];

  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.05"; # Please read the comment before changing.
 
    packages = with pkgs; [ # user packages
      cmake
      libgccjit
      rustc
      rustfmt
      cargo
      clippy
      jdk
      mpv
      # git -> version control
      # gitui -> git terminal ui client
      # librewolf -> firefox based browser
      # tmux -> terminal multiplexer
    ];
 

    file = { # managing config files

    };
 
    sessionVariables = { # user session variables

    };
  };

  programs = { # configuring programs
    home-manager.enable = true; # enable the home manager
  };
}
