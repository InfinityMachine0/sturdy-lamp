{ inputs, lib, config, pkgs, ... }:
{
  networking = {
    firewall = { 
      allowedTCPPorts = TCP_PORTS_REPLACE; 

      allowedUDPPorts = UDP_PORTS_REPLACE;
    };
  };
}