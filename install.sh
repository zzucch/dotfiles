#!/usr/bin/env bash

script_dir=$(dirname "$0")

cd "$script_dir" || exit 1

read -p "Do you want to update the dotfiles repository? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
	echo "Updating dotfiles..."
	git pull
	git submodule update
fi

if ! command -v stow &>/dev/null; then
	echo "Stow could not be found, but is needed. Install it and try again."
	exit 1
fi

find . -maxdepth 1 -not -name ".*" -type d |
	while read -r dotfile; do
		# Remove the leading "./"
		dotfile=$(basename "$dotfile")

		if ! stow --adopt -v "$dotfile"; then
			echo -e "Failed to stow $dotfile"
		fi
	done
