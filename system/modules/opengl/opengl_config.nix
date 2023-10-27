## hardware options
{ inputs, lib, config, pkgs, ... }:
{
  ## boot options
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}