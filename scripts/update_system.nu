#! /usr/bin/env nu

let path_to_config = "/etc/nixos/config_dir"

let git_repo_name = ( doas open --raw ( [ $path_to_config, "values/git_repo_name.conf" ] | path join ) | str trim )
let path_togit_repo = ( [ "/etc/nixos/", $git_repo_name ] | path join | str trim ) 

let username = ( doas open --raw ( [ $path_to_config, "values/username.conf" ] | path join ) | str trim )

doas nix flake update ( [ $path_to_config, "flake.nix" ] | path join | str trim )

doas nixos-rebuild switch --flake ( [ $path_to_config, "#" ,$hostname ] | str join)