# gd; Short for gentoo-deploy. Create an iso image that deploys gentoo.
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

# This file is an example config. Default settings are mentioned and commented out.
# This file is sourced by all gd-*.sh scripts.
# However, variables given in this example only apply to gd-build-kernel.sh

# Destination where the resulting .iso image will be copied
# Default=$TEMP=/var/tmp/gd
# DEST=$TEMP

# Where to look for kernel sources. Ussualy the /usr/src/symlink
# KDIR="/usr/src/linux"

# Use this saved kernel config. Default is to generate a new one.
# KCONFIG=/etc/gd/kconfig-4.9

# Run "make clean" before and after building
# CLEAN=true

# Run "make menuconfig" after constructing .config and before building.
# MENUCONFIG=true

# Number of paralel jobs for compiling.
JOBS=8