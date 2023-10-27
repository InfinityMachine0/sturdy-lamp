#! /usr/bin/env nix-shell
#! nix-shell -i nu -p nushell git doas

let path_to_config = "/mnt/etc/nixos/config_dir"

let git_repo_name = "sturdy-lamp"
doas $git_repo_name | save ( [ $path_to_config, "values/git_repo_name.conf" ] | path join | str trim )

let path_to_git_repo = ( [ "/mnt/etc/nixos", $git_repo_name ] | path join | str trim )

#######################################

def to_continue []:[ null -> null ]{
	mut string_input = "temp"
	while true {
		$string_input = ( input "continue? [y/n]\n" )
		if $string_input =~ "(?i)y" {
			print "############\n"
			return $nothing
		}
		else if $string_input =~ "(?i)n" { 
			print "############\n"
			print "stoping the script"
			exit 1
		} 
		else { 
			print "\n"
		}
	}
}

#######################################

def select_thing [ thing: string, options: string, prompt_options: string ]: [ null -> int ] {
	let prompt = ( [ "select ", $thing, ": ", $options, "\n", $prompt_options] | str join )
	let $thing_selected = ( input $prompt | str trim )
	if $thing_selected =~ ( $options | str replace --all '/' '' ) {
		return ( $thing_selected | into int )
	}
	print "incorrect input data\n"
	exit 1
}

def choose_thing [ thing:string ]: [ null -> string ] {
	let prompt = ( [ "choose ", $thing, ": (no white spaces)\n" ] | str join )
	let thing_chosen = ( input $prompt | str trim )
	return $thing_chosen
}

#######################################

def format_platform [ platform:int ]: [ null -> null ]{
	if $platform == 1 {
		doas nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ../system/modules/btrfs/laptop_btrfs_config.nix
		to_continue
		return $nothing
	}
	else if $platform == 2 {
		doas nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ../system/modules/btrfs/desktop_btrfs_config.nix
		to_continue
		return $nothing
	}
	else if $platform == 3 {
		doas nix --extra-experimental-features nix-command --extra-experimental-features flakes run github:nix-community/disko -- --mode disko ../system/modules/btrfs/virtualbox_btrfs_config.nix
		to_continue
		return $nothing
	}
	else {
		print "incorrect input data\n"
		exit 1
	}
}

#######################################

let platform = ( select_thing "platform" "[1/2/3]" "1. laptop\n2. desktop\n3. virtualbox\n" )
doas $platform | save ( [ $path_to_config, "values/platform.conf" ] | path join )

let gpu = ( select_thing "gpu" "[1/2]" "1. no gpu\n2. nvidia\n" )
doas $gpu | save ( [ $path_to_config, "values/gpu.conf" ] | path join )

let hostname = ( choose_thing "hostname" | str trim )
doas $hostname | save ( [ $path_to_config, "values/hostname.conf" ] | path join )

let username = ( choose_thing "username" | str trim )
doas $username | save ( [ $path_to_config, "values/username.conf" ] | path join )

let ssh_port = ( choose_thing "ssh port" | str trim )

let ssh_ports = ( [ "[ ", $ssh_port, " ]" ] | str join | str trim )
doas $ssh_ports | save ( [ $path_to_config, "values/ssh_ports.conf" ] | path join )

let tcp_ports = ( [ "[ ", $ssh_port, " ]" ] | str join | str trim )
doas $tcp_ports | save ( [ $path_to_config, "values/tcp_ports.conf" ] | path join )

let udp_ports = "[ ]"
doas $udp_ports | save ( [ $path_to_config, "values/udp_ports.conf" ] | path join )

let git_username = ( choose_thing "git username" | str trim )
doas $git_username | save ( [ $path_to_config, "values/git_username.conf" ] | path join )

let git_email = ( choose_thing "git email" | str trim )
doas $git_email | save ( [ $path_to_config, "values/git_email.conf" ] | path join )

#######################################

format_platform $platform

#######################################

# do you need github password
if false {
	doas git clone ( [ "https://github.com/InfinityMachine/", $git_repo_name ] | str join ) /mnt/etc/nixos
}
else {
	doas git clone ( [ "https://github.com/InfinityMachine/", $git_repo_name, ".git" ] | str join ) /mnt/etc/nixos
}

doas nixos-generate-config --no-filesystems --root /mntnixos-generate

doas cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/temp

doas rm /mnt/etc/nixos/configuration.nix

nu ./link_files.nu

to_continue

doas nixos-install --flake ( [ ( [ $path_to_config, "flake.nix" ] | path join | str trim ), $hostname ] | str join | str trim )