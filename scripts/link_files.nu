#! /usr/bin/env nu

def creare_any_link [ start: string, destination: string, fresh_install: int ]: any -> any {
	if $fresh_install == 1 {
		ln -sf $start $destination
	} else {
		doas ln -sf $start $destination
	}
}

def create_link [ type: string, module: string, git_repo_file: string config_file: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	let path_to_git_repo_module_file = ( [ $path_to_git_repo, $type, "modules", $module, $git_repo_file ] | path join )
	let path_to_config_module_file = ( [ $path_to_config, $type, "modules", $module, $config_file ] | path join )

	creare_any_link $path_to_git_repo_module_file $path_to_config_module_file $fresh_install
}

def create_system_link [ module: string, git_repo_file: string config_file: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	create_link "system" $module $git_repo_file $config_file $fresh_install $path_to_git_repo $path_to_config
}

def create_home_manager_link [ module: string, git_repo_file: string config_file: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	create_link "home-manager" $module $git_repo_file $config_file $fresh_install $path_to_git_repo $path_to_config
}

def create_basic_system_link [ module: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	let file_name = ( [ $module, "_config.nix" ] | str join )
	create_system_link $module $file_name $file_name $fresh_install $path_to_git_repo $path_to_config
}

def create_basic_home_manager_link [ module: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	let file_name = ( [ $module, "_config.nix" ] | str join )
	create_home_manager_link $module $file_name $file_name $fresh_install $path_to_git_repo $path_to_config
}

#######################################

def copy_any_file [ start: string, destination: string, fresh_install: int ]: any -> any {
	if $fresh_install == 1 {
		cp $start $destination
	} else {
		doas cp $start $destination
	}
}

def copy_file [ type: string, module: string, git_repo_file: string, config_file: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	let path_to_git_repo_module_file = ( [ $path_to_git_repo, $type, "modules", $module, $git_repo_file ] | path join )
	let path_to_config_module_file = ( [ $path_to_config, $type, "modules", $module, $config_file ] | path join )
	copy_any_file $path_to_git_repo_module_file $path_to_config_module_file $fresh_install
}

def copy_system_file [ module: string, git_repo_file: string config_file: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	copy_file "system" $module $git_repo_file $config_file $fresh_install $path_to_git_repo $path_to_config
}

def copy_home_manager_file [ module: string, git_repo_file: string config_file: string, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	copy_file "home-manager" $module $git_repo_file $config_file $fresh_install $path_to_git_repo $path_to_config
}

#######################################

def read_from [ file: string, fresh_install: int ]: any -> string {
	if $fresh_install == 1 {
		return ( open --raw $file )
	} else {
		return ( doas open --raw $file )
	}
}

#######################################

def save_to_file [ file: string, fresh_install: int ]: any -> any {
	if $fresh_install == 1 {
		$in | save -f $file
	} else {
		$in | doas save -f $file
	}
}

#######################################

def replace_string [ type: string, module: string, config_file: string, string_to_replace: string, string_replacment: string, fresh_install: int, path_to_config: string ]: any -> any {
	let path_to_config_module_file = ( [ $path_to_config, $type, "modules", $module, $config_file ] | path join )

	read_from $path_to_config_module_file $fresh_install | str replace $string_to_replace $string_replacment | save_to_file $path_to_config_module_file $fresh_install
}

def replace_system_string [ module: string, config_file: string, string_to_replace: string, string_replacment: string, fresh_install: int, path_to_config: string ]: any -> any {
	replace_string "system" $module $config_file $string_to_replace $string_replacment $fresh_install $path_to_config
}

def replace_home_manager_string [ module: string, config_file: string, string_to_replace: string, string_replacment: string, fresh_install: int, path_to_config: string ]: any -> any {
	replace_string "home-manager" $module $config_file $string_to_replace $string_replacment $fresh_install $path_to_config
}

#######################################

def select_platform [ platform: int, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	if $platform == 1 {
		create_system_link "platform" "laptop_platform_file.nix" "platform_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_system_link "btrfs" "laptop_btrfs_config.nix" "btrfs_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_home_manager_link "hyprland" "hyprland_laptop_patch.nix" "hyprland_platform_patch.nix" $fresh_install $path_to_git_repo $path_to_config
		return 
	} else if $platform == 2 {
		create_system_link "platform" "desktop_platform_file.nix" "platform_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_system_link "btrfs"  "desktop_btrfs_config.nix" "btrfs_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_home_manager_link "hyprland" "hyprland_desktop_patch.nix" "hyprland_platform_patch.nix" $fresh_install $path_to_git_repo $path_to_config
		return
	} else if $platform == 3 {
		create_system_link "platform" "virtualbox_platform_file.nix" "platform_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_system_link "btrfs" "virtualbox_btrfs_config.nix" "btrfs_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_home_manager_link "hyprland" "hyprland_virtualbox_patch.nix" "hyprland_platform_patch.nix" $fresh_install $path_to_git_repo $path_to_config
		return
	} else {
		print "incorrect input data\n"
		exit
	}
}

def select_gpu [ gpu:int, fresh_install: int, path_to_git_repo: string, path_to_config: string ]: any -> any {
	if $gpu == 1 {
		create_system_link "gpu" "no_gpu_config.nix" "gpu_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_home_manager_link "hyprland" "hyprland_no_nvidia_patch.nix" "hyprland_gpu_patch.nix" $fresh_install $path_to_git_repo $path_to_config
		return
	} else if $gpu == 2 {
		create_system_link "gpu" "nvidia_gpu_config.nix" "gpu_config.nix" $fresh_install $path_to_git_repo $path_to_config
		create_home_manager_link "hyprland" "hyprland_nvidia_patch.nix" "hyprland_gpu_patch.nix" $fresh_install $path_to_git_repo $path_to_config
		return
	} else {
		print "incorrect input data\n"
		exit
	}
}

#######################################

def main [ fresh_install: int = 0 ] any -> any {

	mut path_to_root_temp = "temp"

	if $fresh_install == 1 {
		$path_to_root_temp = "/mnt"
	} else {
		$path_to_root_temp = "/"
	}

	let path_to_root = $path_to_root_temp
	
	#######################################

	let path_to_config = ( [ $path_to_root, "etc/nixos/config_dir" ] | path join | str trim )
	
	let git_repo_name = ( read_from ( [ $path_to_config, "values/git_repo_name.conf" ] | path join ) $fresh_install )
	
	let path_to_git_repo = ( [ $path_to_root, "etc/nixos/", $git_repo_name ] | path join | str trim ) 
	let path_to_thing = ( [ $path_to_root, "etc/nixos" ] | path join | str trim  )
	let path_to_home = ( [ $path_to_root, "home" ] | path join | str trim  )
	
	#######################################
	
	let platform = ( read_from ( [ $path_to_config, "values/platform.conf" ] | path join ) $fresh_install | str trim | into int )
	
	#######################################
	
	let gpu = ( read_from ( [ $path_to_config, "values/gpu.conf" ] | path join ) $fresh_install | str trim | into int )
	
	#######################################
	
	let hostname = ( read_from ( [ $path_to_config, "values/hostname.conf" ] | path join ) $fresh_install | str trim )
	
	let username = ( read_from ( [ $path_to_config, "values/username.conf" ] | path join ) $fresh_install | str trim )
	
	#######################################
	
	let ssh_ports = ( read_from ( [ $path_to_config, "values/ssh_ports.conf" ] | path join ) $fresh_install | str trim )
	
	let tcp_ports = ( read_from ( [ $path_to_config, "values/tcp_ports.conf" ] | path join ) $fresh_install | str trim )
	
	let udp_ports = ( read_from ( [ $path_to_config, "values/udp_ports.conf" ] | path join ) $fresh_install | str trim )
	
	#######################################
	
	let git_username = ( read_from ( [ $path_to_config, "values/git_username.conf" ] | path join ) $fresh_install | str trim )
	
	let git_email = ( read_from ( [ $path_to_config, "values/git_email.conf" ] | path join ) $fresh_install | str trim )
	
	#######################################

	mkdir $path_to_config
	mkdir ( [ $path_to_config, "system" ] | path join )
	
	mkdir ( [ $path_to_config, "system/modules" ] | path join )

	mkdir ( [ $path_to_config, "system/modules/bluetooth" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/btrfs" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/cups" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/doas" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/firewall" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/fonts" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/gpu" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/hyprland" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/keyboard" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/locale" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/networking" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/opengl" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/pipewire" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/platform" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/ssh" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/systemd-boot" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/trackpad" ] | path join )
	mkdir ( [ $path_to_config, "system/modules/users" ] | path join )

	mkdir ( [ $path_to_config, "home-manager" ] | path join )

	mkdir ( [ $path_to_config, "home-manager/modules" ] | path join )
	
	mkdir ( [ $path_to_config, "home-manager/modules/bat" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/bottom" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/dunst" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/foot" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/fzf" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/git" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/gitui" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/gtk" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/home-path" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/hyprland" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/nixvim" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/nushell" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/qt" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/qutebrowser" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/rofi" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/starship" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/waybar" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/wezterm" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/xplr" ] | path join )
	mkdir ( [ $path_to_config, "home-manager/modules/zellij" ] | path join )

	mkdir ( [ $path_to_config, "values" ] | path join )

	mkdir ( [ $path_to_config, "scripts" ] | path join )

	mkdir ( [ "/mnt/home", $username, "wallpapers" ] | path join )

	mkdir ( [ "/mnt/home", $username, "personal_scripts" ] | path join )

	#######################################
	
	select_platform $platform $fresh_install $path_to_git_repo $path_to_config
	
	select_gpu $gpu $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_home_manager_link "bat" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "bottom" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "dunst" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "foot" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "fzf" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_home_manager_link "git" $fresh_install $path_to_git_repo $path_to_config
	create_home_manager_link "git" "git_names.nix" "git_names.nix" $fresh_install $path_to_git_repo $path_to_config
	
	copy_home_manager_file "git" "git_names.nix" "no_edit_git_names.nix" $fresh_install $path_to_git_repo $path_to_config
	
	replace_home_manager_string "git" "no_edit_git_names.nix" "GIT_USERNAME_REPLACE" $git_username $fresh_install $path_to_config
	
	replace_home_manager_string "git" "no_edit_git_names.nix" "GIT_EMAIL_REPLACE" $git_email $fresh_install $path_to_config
	
	#######################################
	
	create_basic_home_manager_link "gitui" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "gtk" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_home_manager_link "home-path" $fresh_install $path_to_git_repo $path_to_config
	
	copy_home_manager_file "home-path" "home-path_config.nix" "no_edit_home-path_config.nix" $fresh_install $path_to_git_repo $path_to_config
	
	replace_home_manager_string "home-path" "no_edit_home-path_config.nix" "USERNAME_REPLACE" $username $fresh_install $path_to_config
	
	#######################################
	
	create_basic_home_manager_link "hyprland" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "nixvim" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "nushell" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "qt" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "qutebrowser" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "rofi" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "starship" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	copy_any_file ( [ $path_to_git_repo, "home-manager/modules/wallpapers" ] | path join ) ( [ "/mnt/home", $username ] | path join ) $fresh_install
	
	#######################################
	
	create_basic_home_manager_link "waybar" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "wezterm" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "xplr" $fresh_install $path_to_git_repo $path_to_config
	create_basic_home_manager_link "zellij" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	creare_any_link ( [ $path_to_git_repo, "home-manager/home.nix" ] | path join ) ( [ $path_to_config, "home-manager/home.nix" ] | path join ) $fresh_install
	
	#######################################
	
	creare_any_link ( [ $path_to_git_repo, "scripts/hyprland.sh" ] | path join ) ( [ $path_to_config, "scripts/hyprland.sh" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/update_system.nu" ] | path join ) ( [ $path_to_config, "scripts/update_system.nu" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/link_files.nu" ] | path join ) ( [ $path_to_config, "scripts/link_files.nu" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/refresh_config.nu" ] | path join ) ( [ $path_to_config, "scripts/refresh_config.nu" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/refresh_config.nu" ] | path join ) ( [ $path_to_config, "scripts/refresh_config_true.nu" ] | path join ) $fresh_install
	
	creare_any_link ( [ $path_to_git_repo, "scripts/hyprland.sh" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/hyprland.sh" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/update_system.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/update_system.nu" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/link_files.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/link_files.nu" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/refresh_config.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/refresh_config.nu" ] | path join ) $fresh_install
	creare_any_link ( [ $path_to_git_repo, "scripts/refresh_config_true.nu" ] | path join ) ( [ $path_to_config, $path_to_home, $username, "personal_scripts/refresh_config_true.nu" ] | path join ) $fresh_install
	
	#######################################
	
	create_basic_system_link "bluetooth" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "cups" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "doas" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_system_link "firewall" $fresh_install $path_to_git_repo $path_to_config
	
	copy_system_file "firewall" "firewall_config.nix" "no_edit_firewall_config.nix" $fresh_install $path_to_git_repo $path_to_config
	
	replace_system_string "firewall" "no_edit_firewall_config.nix" "TCP_PORTS_REPLACE" $tcp_ports $fresh_install $path_to_config
	replace_system_string "firewall" "no_edit_firewall_config.nix" "UDP_PORTS_REPLACE" $udp_ports $fresh_install $path_to_config
	
	#######################################
	
	create_basic_system_link "fonts" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "hyprland" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "keyboard" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "locale" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_system_link "networking" $fresh_install $path_to_git_repo $path_to_config
	create_system_link "networking" "hostname.nix" "hostname.nix" $fresh_install $path_to_git_repo $path_to_config
	
	copy_system_file "networking" "hostname.nix" "no_edit_hostname.nix" $fresh_install $path_to_git_repo $path_to_config
	
	replace_system_string "networking" "no_edit_hostname.nix" "HOSTNAME_REPLACE" $hostname $fresh_install $path_to_config
	
	#######################################
	
	create_basic_system_link "opengl" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "pipewire" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_system_link "ssh" $fresh_install $path_to_git_repo $path_to_config
	create_system_link "ssh" "ssh_ports.nix" "ssh_ports.nix" $fresh_install $path_to_git_repo $path_to_config
	
	copy_system_file "ssh" "ssh_ports.nix" "no_edit_ssh_ports.nix" $fresh_install $path_to_git_repo $path_to_config
	
	replace_system_string "ssh" "no_edit_ssh_ports.nix" "SSHPORTS_REPLACE" $ssh_ports $fresh_install $path_to_config
	
	#######################################
	
	create_basic_home_manager_link "systemd-boot" $fresh_install $path_to_git_repo $path_to_config
	create_basic_system_link "trackpad" $fresh_install $path_to_git_repo $path_to_config
	
	#######################################
	
	create_basic_system_link "users" $fresh_install $path_to_git_repo $path_to_config
	
	copy_system_file "users" "users_config.nix" "no_edit_users_config.nix" $fresh_install $path_to_git_repo $path_to_config
	
	replace_system_string "users" "no_edit_users_config.nix" "USERNAME_REPLACE" $username $fresh_install $path_to_config
	
	#######################################
	
	creare_any_link ( [ $path_to_git_repo, "system/configuration.nix" ] | path join ) ( [ $path_to_config, "system/configuration.nix" ] | path join ) $fresh_install
	
	#######################################
	
	copy_any_file ( [ $path_to_thing, "temp/hardware-configuration.nix" ] | path join ) ( [ $path_to_config, "system/hardware-configuration.nix" ] | path join ) $fresh_install
	
	#######################################
	
	creare_any_link ( [ $path_to_git_repo, "flake.nix" ] | path join ) ( [ $path_to_config, "edit_this_flake.nix" ] | path join ) $fresh_install
	
	copy_any_file ( [ $path_to_git_repo, "flake.nix" ] | path join ) ( [ $path_to_config, "flake.nix" ] | path join ) $fresh_install
	
	read_from ( [ $path_to_config, "flake.nix" ] | path join ) $fresh_install | str replace "USERNAME_REPLACE" $username | save_to_file ( [ $path_to_config, "flake.nix" ] | path join ) $fresh_install
	read_from ( [ $path_to_config, "flake.nix" ] | path join ) $fresh_install | str replace "HOSTNAME_REPLACE" $hostname | save_to_file ( [ $path_to_config, "flake.nix" ] | path join ) $fresh_install
}

