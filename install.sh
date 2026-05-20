#!/usr/bin/env bash

script_dir=$(dirname "$0")

cd "$script_dir" || exit 1

skip_update=false
if [[ "${1:-}" == "-n" || "${1:-}" == "--no" ]]; then
	skip_update=true
	echo "(skipping dotfiles update)"
fi

if ! $skip_update; then
	if ! command -v git &>/dev/null; then
		echo "git could not be found, but is needed. install it and try again."
		exit 1
	fi

	echo "updating dotfiles..."
	git pull
	git submodule update --remote
fi

if ! command -v stow &>/dev/null; then
	echo "stow could not be found, but is needed. install it and try again."
	exit 1
fi

find . -maxdepth 1 -not -name ".*" -type d |
	while read -r dotfile; do
		# remove the leading "./"
		dotfile=$(basename "$dotfile")

		if ! stow --adopt -v "$dotfile"; then
			echo -e "failed to stow $dotfile"
		fi
	done

echo "done"
