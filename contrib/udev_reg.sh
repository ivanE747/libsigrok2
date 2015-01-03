#!/bin/bash

##
## This file is part of the libsigrok project.
##
## Copyright (C) 2015 Ivan E. Veloz Guerrero <ivan747@users.sourceforge.net>
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
##

## If you are a packager, please, copy the .rules file to its corresponding
## udev rules folder in a way that is transparent to the user, 
## if this is possible and considered safe. Remember to rename it to "60_libsigrok.rules"



echo This script gives Linux users read and write permisions to USB devices used
echo by sigrok. Any user in the group plugdev will be able to access these
echo USB devices. It does this by registering a udev rule in /lib/udev/rules.d
echo The rules file being used is located in libsigrok/contrib/z60_libsigrok.rules
echo

read -p "Do you want to continue (you will be asked for root priviledges) [y/N]? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo
	sudo cp -i z60_libsigrok.rules /lib/udev/rules.d/60_libsigrok.rules
	echo Reloading udev rules...
	sudo udevadm control --reload-rules 
	echo Done. You are registered in the following groups:
	groups $USER
	echo
	read -p "Do you want to register yourself in the plugdev group? [y/N] " -n 1 -r
	echo
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
		echo
		sudo groupadd plugdev
		sudo usermod -a -G plugdev $USER
		echo
		echo You are now registered in the following groups:
		groups $USER
		echo You should be able to access all USB devices listed in the rules file without root privileges.
	fi
fi


