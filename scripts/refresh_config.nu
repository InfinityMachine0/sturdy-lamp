#! /usr/bin/env nu

let path_to_config = "/etc/nixos/config_dir"

let git_repo_name = ( doas open --raw ( [ $path_to_config, "values/git_repo_name.conf" ] | path join ) | str trim )
let path_togit_repo = ( [ "/etc/nixos/", $git_repo_name ] | path join | str trim ) 

doas cp ( [ $path_to_git_repo, "scripts/refresh_config_true.nu" ] | path join | str trim ) /etc/nixos/temp
doas cp ( [ $path_to_git_repo, "scripts/link_files.nu" ] | path join | str trim ) /etc/nixos/temp

nu /etc/nixos/temp/refresh_config_true.nu