#!/bin/bash
cd ~/Builds/dwm; updpkgsums; makepkg -efi --noconfirm && killall dwm
