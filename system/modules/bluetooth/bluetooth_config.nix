{ inputs, lib, config, pkgs, ... }:
{
  ## services configuration
  services = { 
    # enable blueman, a bluetooth GUI manager
    blueman.enable = true; 
  };

## hardware settings
  hardware = {
  # bluetooth settings
    bluetooth = {
      # enable bluetooth
      enable = true;

    ## enable A2DP Sink
      settings = { 
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}