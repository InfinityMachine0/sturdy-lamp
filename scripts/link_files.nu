#! /usr/bin/env nu

let git_repo_name = ( doas open --raw ( [ $path_to_config, "values/git_repo_name.conf" ] | path join ) | str trim )

let prompt_1 = "fresh install? : [y/n]\n"

let option_selected = ( input $prompt_1 | str trim )

mut path_to_root = "temp"

if $option_selected =~ "[yY]" {
	$path_to_root = "/mnt"
}
else if $option_selected =~ "[nN]" {
	$path_to_root = "/"
}
else {
	print "incorrect input data\n"
	exit 1
}

let path_togit_repo = ( [ $path_to_root, "etc/nixos/", $git_repo_name ] | path join | str trim ) 
let path_to_config = ( [ $path_to_root, "etc/nixos/config_dir" ] | path join | str trim )
let path_to_thing = ( [ $path_to_root, "etc/nixos" ] | path join | str trim  )
let path_to_home = ( [ $path_to_root, "home" ] | path join | str trim  )

#######################################

def create_link [ type: string, module: string, git_repo_file: string config_file: string ]: [ null -> null ] {
	let path_to_git_repo_module_file = ( [ $path_to_git_repo, $type, "modules", $module, $git_repo_file ] | path join )
	let path_to_config_module_file = ( [ $path_to_config, $type, "modules", $module, $config_file ] | path join )
	doas ln -s $path_to_git_repo_module_file $path_to_config_module_file
}

def create_system_link [ module: string, git_repo_file: string config_file: string ]: [ null -> null ] {
	create_link "system" $module $git_repo_file $config_file
}

def create_home_manager_link [ module: string, git_repo_file: string config_file: string ]: [ null -> null ] {
	create_link "home-manager" $module $git_repo_file $config_file
}

def create_basic_system_link [ module: string ]: [ null -> null ] {
	let file_name = ( [ $module, "_config.nix" ] | str join )
	create_system_link $module $file_name $file_name
}

def create_basic_home_manager_link [ module: string ]: [ null -> null ] {
	let file_name = ( [ $module, "_config.nix" ] | str join )
	create_home_manager_link $module $file_name $file_name
}

#######################################

def copy_file [ type: string, module: string, git_repo_file: string, config_file: string ]: [ null -> null ] {
	let path_to_git_repo_module_file = ( [ $path_to_git_repo, $type, "modules", $module, $git_repo_file ] | path join )
	let path_to_config_module_file = ( [ $path_to_config, $type, "modules", $module, $config_file ] | path join )
	doas cp $path_to_git_repo_module_file $path_to_config_module_file
}

def copy_system_file [ module: string, git_repo_file: string config_file: string ]: [ null -> null ] {
	copy_file "system" $module $git_repo_file $config_file
}

def copy_home_manager_file [ module: string, git_repo_file: string config_file: string ]: [ null -> null ] {
	copy_file "home-manager" $module $git_repo_file $config_file
}

#######################################

def replace_string [ type: string, module: string, config_file: string, string_to_replace: string, string_replacment: string ]: [ null -> null ] {
	let path_to_config_module_file = ( [ $path_to_config, $type, "modules", $module, $config_file ] | path join )

	doas open --raw $path_to_config_module_file | str replace $string_to_replace $string_replacment | save $path_to_config_module_file
}

def replace_system_string [ module: string, config_file: string, string_to_replace: string, string_replacment: string ]: [ null -> null ] {
	replace_string "system" $module $config_file $string_to_replace $string_replacment
}

def replace_home_manager_string [ module: string, config_file: string, string_to_replace: string, string_replacment: string ]: [ null -> null ] {
	replace_string "home-manager" $module $config_file $string_to_replace $string_replacment
}

#######################################

def select_platform [ platform: int ]: [ null -> null ] {
	if $platform == 1 {
		create_system_link "platform" "laptop_platform_file.nix" "platform_config.nix"
		create_system_link "btrfs" "laptop_btrfs_config.nix" "btrfs_config.nix"
		create_home_manager_link "hyprland" "hyprland_laptop_patch.nix" "hyprland_platform_patch.nix"
		return $nothing
	}
	else if $platform == 2 {
		create_system_link "platform" "desktop_platform_file.nix" "platform_config.nix"
		create_system_link "btrfs"  "desktop_btrfs_config.nix" "btrfs_config.nix"
		create_home_manager_link "hyprland" "hyprland_desktop_patch.nix" "hyprland_platform_patch.nix"
		return $nothing
	}
	else if $platform == 3 {
		create_system_link "platform" "virtualbox_platform_file.nix" "platform_config.nix"
		create_system_link "btrfs" "virtualbox_btrfs_config.nix" "btrfs_config.nix"
		create_home_manager_link "hyprland" "hyprland_virtualbox_patch.nix" "hyprland_platform_patch.nix"
		return $nothing
	}
	else {
		print "incorrect input data\n"
		exit 1
	}
}

def select_gpu [ gpu:int ]: [ null -> null ]{
	if $gpu == 1 {
		create_system_link "gpu" "no_gpu_config.nix" "gpu_config.nix"
		create_home_manager_link "hyprland" "hyprland_no_nvidia_patch.nix" "hyprland_gpu_patch.nix"
		return $nothing
	}
	else if $gpu == 2 {
		create_system_link "gpu" "nvidia_gpu_config.nix" "gpu_config.nix"
		create_home_manager_link "hyprland" "hyprland_nvidia_patch.nix" "hyprland_gpu_patch.nix"
		return $nothing
	}
	else {
		print "incorrect input data\n"
		exit 1
	}
}

#######################################

let platform = ( doas open --raw ( [ $path_to_config, "values/platform.conf" ] | path join ) | str trim | into int )

let gpu = ( doas open --raw ( [ $path_to_config, "values/gpu.conf" ] | path join ) | str trim | into int )

let hostname = ( doas open --raw ( [ $path_to_config, "values/hostname.conf" ] | path join ) | str trim )

let username = ( doas open --raw ( [ $path_to_config, "values/username.conf" ] | path join ) | str trim )

let ssh_ports = ( doas open --raw ( [ $path_to_config, "values/ssh_ports.conf" ] | path join ) | str trim )

let tcp_ports = ( doas open --raw ( [ $path_to_config, "values/tcp_ports.conf" ] | path join ) | str trim )

let udp_ports =( doas open --raw ( [ $path_to_config, "values/udp_ports.conf" ] | path join ) | str trim )

let git_username = ( doas open --raw ( [ $path_to_config, "values/git_username.conf" ] | path join ) | str trim )

let git_email = ( doas open --raw ( [ $path_to_config, "values/git_email.conf" ] | path join ) | str trim )

#######################################

select_platform $platform

select_gpu $gpu

#######################################

create_basic_home_manager_link "bat"
create_basic_home_manager_link "bottom"
create_basic_home_manager_link "dunst"
create_basic_home_manager_link "foot"
create_basic_home_manager_link "fzf"

#######################################

create_basic_home_manager_link "git"
create_home_manager_link "git" "git_names.nix" "git_names.nix"

copy_home_manager_file "git" "git_names.nix" "no_edit_git_names.nix"

replace_home_manager_string "git" "no_edit_git_names.nix" "GIT_USERNAME_REPLACE" $git_username

replace_home_manager_string "git" "no_edit_git_names.nix" "GIT_EMAIL_REPLACE" $git_email

#######################################

create_basic_home_manager_link "gitui"
create_basic_home_manager_link "gtk"

#######################################

create_basic_home_manager_link "home-path"

copy_home_manager_file "home-path" "home-path_config.nix" "no_edit_home-path_config.nix"

replace_home_manager_string "home-path" "no_edit_home-path_config.nix" "USERNAME_REPLACE" $username

#######################################

create_basic_home_manager_link "hyprland"
create_basic_home_manager_link "nixvim"
create_basic_home_manager_link "nushell"
create_basic_home_manager_link "qt"
create_basic_home_manager_link "qutebrowser"
create_basic_home_manager_link "rofi"
create_basic_home_manager_link "starship"

#######################################

doas cp ( [ $path_to_git_repo, "home-manager/modules/wallpapers" ] | path join ) ( [ "/mnt/home", $username ] | path join )

#######################################

create_basic_home_manager_link "waybar"
create_basic_home_manager_link "wezterm"
create_basic_home_manager_link "xplr"
create_basic_home_manager_link "zellij"

#######################################

doas ln -s ( [ $path_to_git_repo, "home-manager/home.nix" ] | path join ) ( [ $path_to_config, "home-manager/home.nix" ] | path join )

#######################################

doas ln -s ( [ $path_to_git_repo, "scripts/hyprland.sh" ] | path join ) ( [ $path_to_config, "scripts/hyprland.sh" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/update_system.nu" ] | path join ) ( [ $path_to_config, "scripts/update_system.nu" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/link_files.nu" ] | path join ) ( [ $path_to_config, "scripts/link_files.nu" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/refresh_config.nu" ] | path join ) ( [ $path_to_config, "scripts/refresh_config.nu" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/refresh_config.nu" ] | path join ) ( [ $path_to_config, "scripts/refresh_config_true.nu" ] | path join )

doas ln -s ( [ $path_to_git_repo, "scripts/hyprland.sh" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/hyprland.sh" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/update_system.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/update_system.nu" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/link_files.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/link_files.nu" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/refresh_config.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/refresh_config.nu" ] | path join )
doas ln -s ( [ $path_to_git_repo, "scripts/refresh_config_true.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/refresh_config_true.nu" ] | path join )

#######################################

create_basic_system_link "bluetooth"
create_basic_system_link "cups"
create_basic_system_link "doas"

#######################################

create_basic_system_link "firewall"

copy_system_file "firewall" "firewall_config.nix" "no_edit_firewall_config.nix"

replace_system_string "firewall" "no_edit_firewall_config.nix" "TCP_PORTS_REPLACE" $tcp_ports
replace_system_string "firewall" "no_edit_firewall_config.nix" "UDP_PORTS_REPLACE" $udp_ports

#######################################

create_basic_system_link "fonts"
create_basic_system_link "hyprland"
create_basic_system_link "keyboard"
create_basic_system_link "locale"

#######################################

create_basic_system_link "networking"
create_system_link "networking" "hostname.nix" "hostname.nix"

copy_system_file "networking" "hostname.nix" "no_edit_hostname.nix"

replace_system_string "networking" "no_edit_hostname.nix" "HOSTNAME_REPLACE" $hostname

#######################################

create_basic_system_link "opengl"
create_basic_system_link "pipewire"

#######################################

create_basic_system_link "ssh"
create_system_link "ssh" "ssh_ports.nix" "ssh_ports.nix"

copy_system_file "ssh" "ssh_ports.nix" "no_edit_ssh_ports.nix"

replace_system_string "ssh" "no_edit_ssh_ports.nix" "SSHPORTS_REPLACE" $ssh_ports

#######################################

create_basic_home_manager_link "systemd-boot"
create_basic_system_link "trackpad"

#######################################

create_basic_system_link "users"

copy_system_file "users" "users_config.nix" "no_edit_users_config.nix"

replace_system_string "users" "no_edit_users_config.nix" "USERNAME_REPLACE" $username

#######################################

doas ln -s ( [ $path_to_git_repo, "system/configuration.nix" ] | path join ) ( [ $path_to_config, "system/configuration.nix" ] | path join )

#######################################

doas cp ( [ $path_to_thing, "temp/hardware-configuration.nix" ] ) ( [ $path_to_config, "system/hardware-configuration.nix" ] | path join )

#######################################

doas ln -s ( [ $path_to_git_repo, "flake.nix" ] | path join ) ( [ $path_to_config, "edit_this_flake.nix" ] | path join )

doas cp ( [ $path_to_git_repo, "flake.nix" ] | path join ) ( [ $path_to_config, "flake.nix" ] | path join )

doas open --raw ( [ $path_to_config, "flake.nix" ] | path join ) | str replace "USERNAME_REPLACE" $username | save ( [ $path_to_config, "flake.nix" ] | path join )
doas open --raw ( [ $path_to_config, "flake.nix" ] | path join ) | str replace "HOSTNAME_REPLACE" $hostname | save ( [ $path_to_config, "flake.nix" ] | path join )