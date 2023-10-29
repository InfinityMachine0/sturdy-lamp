#! /usr/bin/env nu

let path_to_config = "/etc/nixos/config_dir"

let git_repo_name = ( doas open --raw ( [ $path_to_config, "values/git_repo_name.conf" ] | path join ) | str trim )
let path_to_git_repo = ( doas open --raw ( [ $path_to_config, "values/path_to_git_repo.conf" ] | path join ) | str trim )

let username = ( doas open --raw ( [ $path_to_config, "values/username.conf" ] | path join ) | str trim )

doas mv -f ( [ $path_to_config, "system/hardware-config.nix" ] | path join | str trim ) /tmp

doas rm -r ( [ $path_to_config, "system" ] | path join | str trim )
doas rm -r ( [ $path_to_config, "home-manager" ] | path join | str trim )
doas rm -r ( [ $path_to_config, "scripts" ] | path join | str trim )
doas rm -r ( [ "/home", $username, "personal_scripts" ] | path join | str trim )

nu ./link_files.nu 0