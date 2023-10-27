{ inputs, lib, config, pkgs, ... }:
{
  ## services configuration
  services = { 
  ## x11 server settings
    xserver = { 
      # use the polish keyboard layout
      layout = "pl"; 

      # extra keyboard options
      xkbOptions = "eurosign:5,kpdl:dot,caps:escape,lv3:ralt_switch"; 
        # eurosign:5 -> eurosign on "5" key on the third level
        # kpdl:dot -> numpad "dot" key set to a dot
        # caps:escape -> use "caps lock" key as an additional escape key
        # lv3:ralt_switch -> use right "alt" key as a key to access the third level
    };
  };
}