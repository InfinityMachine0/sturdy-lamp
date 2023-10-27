#! /usr/bin/env sh

cd ~

export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER_ALLOW_SOFTWARE=1
export XDG_SESSION_TYPE=wayland
export XCURSOR_SIZE=10

exec Hyprland
