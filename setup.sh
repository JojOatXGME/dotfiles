#!/bin/bash


# Set bash options (for error handling)
# ----------------------------------------------------------------------

set -o errexit          # like `set -e`, fail if command fails
set -o nounset          # like `set -u`, fail if variable missing
set -o pipefail         # fail if one component in a pipe fails

# Logging functions
# ----------------------------------------------------------------------

info() {
	if [ -t 1 ]; then
		printf "  [ \033[00;34m..\033[0m ] $1\n"
	else
		echo "  [ .. ] $1\n"
	fi
}

success() {
	if [ -t 1 ]; then
		printf "\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
	else
		echo "  [ OK ] $1\n"
	fi
}

fail() {
	if [ -t 2 ]; then
		printf "\033[2K  [\033[0;31mFAIL\033[0m] $1\n" >&2
	else
		echo "  [FAIL] $1\n" >&2
	fi
}

# Get directory where the dotfiles are installed
# ----------------------------------------------------------------------

DOTFILES="$(dirname "$(realpath -s "$0")")"
if ! [ -d "$DOTFILES" ]; then
	fail 'Could not resolve path to Dotfiles.'
	exit 1
fi

# Command line options
# ----------------------------------------------------------------------

overwrite_mode="none"
copy=false
simulate=false

# Other functions
# ----------------------------------------------------------------------

link_file() {
	local src="$1" dst="$2"

	if [ $simulate == "true" ]; then
		if [ -e "$dst" ]; then
			case "$overwrite_mode" in
				"force")
					if [ $copy == "true" ]; then
						info "would copy '$src' to '$dst'"
					else
						info "would link '$src' to '$dst'"
					fi
					;;
				"skip")
					info "would skip '$src'"
					;;
				*)
					fail "File already exists: $dst"
					;;
			esac
		else
			if [ $copy == "true" ]; then
				info "would copy '$src' to '$dst'"
			else
				info "would link '$src' to '$dst'"
			fi
		fi
	elif [ -e "$dst" ]; then
		case "$overwrite_mode" in
			"force")
				if [ $copy == "true" ]; then
					cp -T --remove-destination "$src" "$dst" && \
						success "copied '$src' to '$dst' (overwritten)" || \
						exit $?
				else
					ln -sf "$src" "$dst" && \
						success "linked '$src' to '$dst' (overwritten)" || \
						exit $?
				fi
				;;
			"skip")
				success "skipped '$src'"
				;;
			*)
				fail "File already exists: $dst"
				fail "Use '$0 -s' to skip or '$0 -f' to overwrite existing files."
				exit 1
				;;
		esac
	else
		if [ $copy == "true" ]; then
			cp -T -n "$src" "$dst" && \
				success "copied '$src' to '$dst'" || \
				exit $?
		else
			ln -s "$src" "$dst" && \
				success "linked '$src' to '$dst'" || \
				exit $?
		fi
	fi
}

# Check dependencies
# ----------------------------------------------------------------------

if [ -z "$HOME" ]; then
	fail '$HOME is not set.'
	exit 1
fi

# Read command line arguments
# ----------------------------------------------------------------------

while getopts ':cfns' opt
do
	case $opt in
		c)
			copy=true
			;;
		f)
			overwrite_mode="force"
			;;
		n)
			simulate=true
			;;
		s)
			overwrite_mode="skip"
			;;
		:)
			fail "Missing argument behind -$OPTARG"
			exit 1
			;;
		*)
			fail "Invalid option: -$OPTARG"
			exit 1
			;;
	esac
done

shift $((OPTIND-1))
if [ $# -ne 0 ]; then
	fail "Unknown argument: $1"
	exit 1
fi

# Link files called *.symlink
# ----------------------------------------------------------------------

while read -r src; do
	dst="$HOME/.$(basename "${src%.*}")"
	link_file "$src" "$dst"
done <<< "$(find -H "$DOTFILES" -maxdepth 2 -name '*.symlink' '!' -path '*.git')"
