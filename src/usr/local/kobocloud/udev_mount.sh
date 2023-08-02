#!/bin/sh
#load config
. $(dirname $0)/config.sh

#create work dirs
[ ! -e "$Logs" ] && mkdir -p "$Logs" >/dev/null 2>&1
[ ! -e "$Lib" ] && mkdir -p "$Lib" >/dev/null 2>&1
[ ! -e "$SD" ] && mkdir -p "$SD" >/dev/null 2>&1

if [ ! -e $UserConfig ]; then
  if [ -e $ConfigFile ]; then
    cp $ConfigFile $UserConfig
  else
    echo "# Add your URLs to this file" > $UserConfig
    echo "# Remove the # from the following line to uninstall KoboCloud" >> $UserConfig
    echo "#UNINSTALL" >> $UserConfig
  fi
fi

# Below gives me double entries in the library so disabled it.

#bind mount to subfolder of SD card on reboot
#mountpoint -q "$SD"
#if [ $? -ne 0 ]; then
#  mount --bind "$Lib" "$SD"
#  echo sd add /dev/mmcblk1p1 >> /tmp/nickel-hardware-status
#fi

# Start an update of the library just in case. Notice that you will need
# nickeldbus installed on your e-book reader https://github.com/shermp/NickelDBus
qndb -t 30000 -s pfmDoneProcessing -m pfmRescanBooksFull
