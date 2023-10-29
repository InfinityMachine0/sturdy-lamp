# sturdy-lamp

sudo su

nix-channel --add https://nixos.org/channels/nixos-unstable nixos

nix-channe; --update

nix-shell -p git nushell

git clone https://github.com/InfinityMachine0/sturdy-lamp

nu ./sturdy-lamp/scripts/install_script.nu

exit

nixos --flake path_to_flake#hostname ( this is command printed by install_script.nu )