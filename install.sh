#!/bin/bash
_username=$(whoami)
echo echo "Current hostname $_username"
echo 'Enter the hostname, optional.'
read _hostname
_hostname=$( echo $_hostname | tr -d ' ' )

if ! pkg update -y -q
then exit 1; fi

if ! pkg upgrade -y -q
then exit 1; fi

if ! pkg install minidlna -y -q
then exit 1; fi

mkdir ~/media
_minidlna_conf=/data/data/com.termux/files/usr/etc/minidlna.conf
_mediadir='media_dir=\/data\/data\/com.termux\/files\/home'

sed -i "s/$_mediadir/$_mediadir\/media/g" $_minidlna_conf

if [ "$_hostname" ]
then
	sed -i "s/#friendly_name=My DLNA Server/friendly_name=$_hostname/g" $_minidlna_conf
fi

minidlnad -S
