{ inputs, lib, config, pkgs, ... }:
{
  services = {
    libinput = { # touchpad support
      enable = true; # enable touchpad support

      touchpad = { # specific touchpad settings
        tappingButtonMap = "lrm"; # set the tapping options for 1/2/3 finger taps
          # 1 finger tap -> left mouse button
          # 2 finger tap -> rigth mouse button
          # 3 finger tap -> middle mouse button
      };
    };
  };
}