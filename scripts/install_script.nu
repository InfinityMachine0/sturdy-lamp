#! /usr/bin/env nu

let path_to_config = "/mnt/etc/nixos/config_dir"

let git_repo_name = "sturdy-lamp"

let path_to_git_repo = ( [ "/mnt/etc/nixos", $git_repo_name ] | path join )

def to_continue []: any -> any {
	mut string_input = "temp"
	let prompt = "continue? [y/n]" 
	while true {
		print $prompt
		$string_input = ( input | str trim )
		if $string_input =~ "(?i)y" {
			print "\n############\n"
			return
		} else if $string_input =~ "(?i)n" { 
			print "\n############\n"
			print "stoping the script"
			exit
		} else { 
			print " "
		}
	}
}

#######################################

def select_thing [ thing: string, options: string, prompt_options: string ]: any -> int {
	let prompt = ( [ "select ", $thing, ": ", $options, "\n", $prompt_options] | str join )
	print $prompt
	let thing_selected = ( input | str trim )
	if $thing_selected =~ ( $options | str replace --all '/' '' ) {
		return ( $thing_selected | into int )
	}
	print "incorrect input data"
	return ( -1 )
}

def choose_thing [ thing: string ]: any -> string {
	let prompt = ( [ "choose ", $thing, ": (no white spaces)" ] | str join )
	print $prompt
	let thing_chosen = ( input | str trim )
	return $thing_chosen
}

#######################################

def format_platform [ platform: int ]: any -> any {
	if $platform == 1 {
		nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ( [ /home/nixos, $git_repo_name, system/modules/btrfs/laptop_btrfs_config.nix ] | path join )
		return
	} else if $platform == 2 {
		nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ( [ /home/nixos, $git_repo_name, system/modules/btrfs/desktop_btrfs_config.nix ] | path join )
		return
	} else if $platform == 3 {
		nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ( [ /home/nixos, $git_repo_name, system/modules/btrfs/virtualbox_btrfs_config.nix ] | path join )
		return
	} else {
		print "incorrect input data\n"
		exit
	}
}

#######################################

def main []: any -> any {
	let platform = ( select_thing "platform" "[1/2/3]" "1. laptop\n2. desktop\n3. virtualbox" )

	print " "
	
	if $platform == -1 {
		exit
	}
	
	#######################################
	
	let gpu = ( select_thing "gpu" "[1/2]" "1. no gpu\n2. nvidia" )

	print " "
	
	if $gpu == -1 {
		exit
	}
	
	#######################################
	
	let hostname = ( choose_thing "hostname" | str trim )

	print " "
	
	let username = ( choose_thing "username" | str trim )

	print " "
	
	#######################################
	
	let ssh_port = ( choose_thing "ssh port" | str trim )

	print " "
	
	let ssh_ports = ( [ "[ ", $ssh_port, " ]" ] | str join | str trim )
	
	let tcp_ports = ( [ "[ ", $ssh_port, " ]" ] | str join | str trim )
	
	let udp_ports = "[ ]"
	
	#######################################
	
	let git_username = ( choose_thing "git username" | str trim )

	print " "
	
	let git_email = ( choose_thing "git email" | str trim )	

	print " "

	to_continue
	
	#######################################
	
	format_platform $platform

	print " "

	to_continue
	
	#######################################
	
	git clone ( [ "https://github.com/InfinityMachine0/", $git_repo_name ] | str join ) ( [ "/mnt/etc/nixos", $git_repo_name ] | path join )

	print " "

	to_continue

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

	$git_repo_name | save ( [ $path_to_config, "values/git_repo_name.conf" ] | path join )

	#######################################
	
	$platform | save ( [ $path_to_config, "values/platform.conf" ] | path join )

	$gpu | save ( [ $path_to_config, "values/gpu.conf" ] | path join )
	
	#######################################
	
	$hostname | save ( [ $path_to_config, "values/hostname.conf" ] | path join )
	
	$username | save ( [ $path_to_config, "values/username.conf" ] | path join )
	
	#######################################
	
	$ssh_ports | save ( [ $path_to_config, "values/ssh_ports.conf" ] | path join )
	
	$tcp_ports | save ( [ $path_to_config, "values/tcp_ports.conf" ] | path join )
	
	$udp_ports | save ( [ $path_to_config, "values/udp_ports.conf" ] | path join )

	#######################################
	
	$git_username | save ( [ $path_to_config, "values/git_username.conf" ] | path join )
	
	$git_email | save ( [ $path_to_config, "values/git_email.conf" ] | path join )

	#######################################
	
	nixos-generate-config --no-filesystems --root /mnt

	print " "
	
	to_continue

	#######################################
	
	cp -f /mnt/etc/nixos/hardware-configuration.nix /tmp

	rm /mnt/etc/nixos/hardware-configuration.nix
	
	rm /mnt/etc/nixos/configuration.nix

	#######################################
	
	nu ( [ "/home/nixos", $git_repo_name, "scripts/link_files.nu" ] | path join ) 1
	
	print " "
	
	to_continue

	#######################################
	print ( [ "nixos-install --flake " ,$path_to_config, "#", $hostname ] | str join )
	print "             ^"
	print "execute that | command"
}