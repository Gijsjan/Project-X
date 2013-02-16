#!/bin/bash

# user must be root
if [ "$(id -u)" != "0" ]; then
   echo "Uninstallation must be run as root" 1>&2
   exit 1
fi

# remove any existing files and folders
echo Removing application...
echo
rm -r -v -f /opt/lxmed
rm -v /usr/share/applications/lxmed.desktop
rm -v /usr/bin/lxmed
rm -v /bin/lxmed
echo
echo Application successfully removed.
