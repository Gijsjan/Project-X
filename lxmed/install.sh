#!/bin/bash
##########################################################################
# This script installs lxmed application to your system. It adds
# a shortcut to your main menu in
# Preferences -> Main Menu Editor menu
# or
# System -> Preferences -> Main Menu Editor
# depending on your distribution
#
# Author: Marko Čičak, cicakmarko@yahoo.com
##########################################################################

# user must be root
if [ "$(id -u)" != "0" ]; then
   echo "Installation must be run as root" 1>&2
   exit 1
fi

echo Installing application...
echo

# remove any existing files and folders
echo Removing any previous installed files and folders...
rm -r -v -f /opt/lxmed
rm -v /usr/share/applications/lxmed.desktop
rm -v /bin/lxmed    # needed for old lxmed version, will be removed in future
rm -v /usr/bin/lxmed

# copy new files
mkdir -v /opt/lxmed
cp -v content/lxmed /usr/bin
chmod -v +x /usr/bin/lxmed
cp -v content/LXMenuEditor.jar /opt/lxmed
cp -v content/uninstall.sh /opt/lxmed
chmod -v +x /opt/lxmed/uninstall.sh
cp -v content/lxmed.png /opt/lxmed
cp -v content/lxmed.desktop /usr/share/applications
echo
echo "Installation sucessfully completed. Enter lxmed to run application or check Preferences -> Main Menu Editor in your main menu"
echo
