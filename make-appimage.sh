#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q supertux | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/supertux2.svg
export DESKTOP=/usr/share/applications/supertux2.desktop
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1

# Deploy dependencies
quick-sharun /usr/bin/supertux* \
             /usr/share/games/supertux* \
             /usr/share/pixmaps/supertux*

# Turn AppDir into AppImage
quick-sharun --make-appimage
