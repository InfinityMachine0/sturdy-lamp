#### virtual box options
{ inputs, lib, config, pkgs, ... }:
let
### shared folders
  # directory for shared stuff
  VirtualBoxShare = "/VirtualBoxShare"; 
  # name of the shared host directory
  SharedDir = "share"; 
in
{
  # idk, said to add it
  boot.initrd.checkJournalingFS = false; 

  virtualisation.virtualbox.guest.enable = true;

  # for shared folders
  fileSystems.${VirtualBoxShare} = { 
    fsType = "vboxsf";
    device = SharedDir;
    options = [ "rw" "nofail" ];
  };
}