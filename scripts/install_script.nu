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
			print "\n"
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
		to_continue
		return
	} else if $platform == 2 {
		nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ( [ /home/nixos, $git_repo_name, system/modules/btrfs/desktop_btrfs_config.nix ] | path join )
		to_continue
		return
	} else if $platform == 3 {
		nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ( [ /home/nixos, $git_repo_name, system/modules/btrfs/virtualbox_btrfs_config.nix ] | path join )
		to_continue
		return
	} else {
		print "incorrect input data\n"
		exit
	}
}

#######################################

def main [ git_hub_password: int = 0 ]: any -> int {

	to_continue

	#######################################

	let platform = ( select_thing "platform" "[1/2/3]" "1. laptop\n2. desktop\n3. virtualbox" )

	print "\n"
	
	if $platform == -1 {
		exit
	}
	
	#######################################
	
	let gpu = ( select_thing "gpu" "[1/2]" "1. no gpu\n2. nvidia" )

	print "\n"
	
	if $gpu == -1 {
		exit
	}
	
	#######################################
	
	let hostname = ( choose_thing "hostname" | str trim )

	print "\n"
	
	let username = ( choose_thing "username" | str trim )

	print "\n"
	
	#######################################
	
	let ssh_port = ( choose_thing "ssh port" | str trim )

	print "\n"
	
	let ssh_ports = ( [ "[ ", $ssh_port, " ]" ] | str join | str trim )
	
	let tcp_ports = ( [ "[ ", $ssh_port, " ]" ] | str join | str trim )
	
	let udp_ports = "[ ]"
	
	#######################################
	
	let git_username = ( choose_thing "git username" | str trim )

	print "\n"
	
	let git_email = ( choose_thing "git email" | str trim )	

	print "\n"
	
	#######################################

	to_continue
	
	format_platform $platform
	
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
	
	# do you need github password
	if $git_hub_password == 0 {
		git clone ( [ "https://github.com/InfinityMachine/", $git_repo_name, ".git" ] | str join ) /mnt/etc/nixos
	} else {
		git clone ( [ "https://github.com/InfinityMachine/", $git_repo_name ] | str join ) /mnt/etc/nixos
	}
	
	nixos-generate-config --no-filesystems --root /mntnixos-generate

	to_continue
	
	mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/temp
	
	rm /mnt/etc/nixos/configuration.nix
	
	nu ./link_files.nu 1
	
	to_continue
	
	nixos-install --flake ( [ ( [ $path_to_config, "flake.nix" ] | path join | str trim ), $hostname ] | str join )
}