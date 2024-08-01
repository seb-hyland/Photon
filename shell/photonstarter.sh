#!/bin/bash

docker run -d \
       -e XDG_RUNTIME_DIR=/tmp \
       -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
       -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY \
       -v "$(wslpath -w "$HOME"):/Local" \
       sebastianhyland/photon:latest 
exit 0
