{ inputs, lib, config, pkgs, ... }:
{
  security = {
    sudo = {
      enable = false;
    };

    doas = {
      enable = true;
    };
  };
}