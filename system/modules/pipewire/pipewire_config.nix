## wayland protocol configuration
{ inputs, lib, config, pkgs, ... }: 
{
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;

    audio.enable = true;
    
    alsa = { 
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;
  };  
}