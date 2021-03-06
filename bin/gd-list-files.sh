#!/bin/bash
# gd; Create an as small as possible iso image, 
# containing only the bare minimals to download and extract a stage-3.
#
# Copyright (C) 2018  Tim Möhlmann
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [ $# -eq 0 ] ; then
	echo "usage $0 list of COMMANDS"
	exit 1
fi

COMMANDS=$@

# This script is run from a chroot. Making sure $PATH is set correctly
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

# uclibc does not provide ldd script, so we define it here.
ldd () {
	LD_TRACE_LOADED_OBJECTS=1 $1
}

set FILES
# addFile adds a file to the FILES list. If file is a symlink,
# it will also find and add the destination.
# If a file is not found, a notice is printed and the function returns 1
addFile() {
	file="$1"
	# Check if file is already included in list
	echo "$FILES" | grep -q "$file" && return
	if [ ! -e $file ]; then
		echo "!!! File not found: $file, skipping..." 1>&2 
		return 1
	fi
	FILES="$FILES $file"
	if [ -L "$file" ]; then
		addFile "$(realpath $file)"
	fi
}

# addLibs finds the lib files and add them to "FILES"
addLibs() {
	ldd=$(ldd $1) || return
	for lib in $(echo "$ldd" | cut -d'>' -f2 | awk '{print $1}'); do
			addFile "$lib"
	done
	return
}

for cmd in $COMMANDS; do
	bin=$(which $cmd) || exit 1
	addFile $bin
	if [[ "$(file $bin)" = *"dynamically"* ]]; then
		addLibs $bin
	fi
done
echo $FILES
exit 0