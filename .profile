#!/bin/sh
################################################################################
# PROFILE
# Author: Jakob Janzen
# Last Modified: 2026-03-20
#
# ~/.profile
################################################################################

if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	# shellcheck disable=SC1091
	. "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

