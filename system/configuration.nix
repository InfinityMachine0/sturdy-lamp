# main configuration file
{ inputs, lib, config, pkgs, ... }:
{
## You can import other NixOS modules here
  imports = [
    ./hardware-configuration.nix

    ./modules/bluetooth/bluetooth_config.nix

    ./modules/btrfs/btrfs_config.nix

    ./modules/cups/cups_config.nix

    ./modules/doas/doas_config.nix

    ./modules/firewall/no_edit_firewall_config.nix

    ./modules/fonts/fonts_config.nix

    ./modules/gpu/gpu_config.nix

    ./modules/hyprland/hyprland_config.nix

    ./modules/keyboard/keyboard_config.nix

    ./modules/locale/locale_config.nix

    ./modules/networking/networking_config.nix

    ./modules/opengl/opengl_config.nix

    ./modules/pipewire/pipewire_config.nix

    ./modules/platfrom/platfrom_config.nix

    ./modules/ssh/ssh_config.nix

    ./modules/systemd-boot/systemd-boot_config.nix

    ./modules/trackpad/trackpad_config.nix

    ./moduels/users/no_edit_users_config.nix
  ];

## nixpkgs settings
  nixpkgs = {
  ## Configure your nixpkgs instance
    config = {
      # enable unfree packages
      allowUnfree = true;
    };
  };

## nix settings
  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";

      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

## system packages
  environment.systemPackages = with pkgs; [ 
    # basic text editor
    vim
    # for downloading files over the internet
    wget
    # version control software 
    git
    # lists of directories as a tree
    tree 
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}

