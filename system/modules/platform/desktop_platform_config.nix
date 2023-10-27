## hardware options
{ inputs, lib, config, pkgs, ... }:
{
  ## boot options
  boot = {
    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest; 
  };
}