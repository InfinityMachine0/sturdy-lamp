{ inputs, lib, config, pkgs, ... }:
{
  # setting the time zone
  time.timeZone = "Europe/Warsaw"; 

## localization options
  i18n = { 
    # language and others
    defaultLocale = "en_US.UTF-8"; 
  
  ## extra localization settings
    extraLocaleSettings = { 
      # 24h clock
      LC_TIME = "en_GB.UTF-8"; 

      LC_COLLATE = "pl_PL.UTF-8";
      LC_MEASUREMENT = "pl_PL.UTF-8";
      LC_MONETARY = "pl_PL.UTF-8";
      LC_NAME = "pl_PL.UTF-8";
      LC_PAPER = "pl_PL.UTF-8";
      LC_TELEPHONE = "pl_PL.UTF-8";
    };
  };
}