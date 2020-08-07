#!/bin/bash

aux=0

while [ $aux == 0 ]; do
	c=$(lsblk | grep -c media)
	if [ $c == 0 ]; then
		echo '**No hay dispositivo USB**'	
	fi
	if [ $c != 0 ]; then
		echo '**se encontro '$c 'dispositivo/s USB**'
		chmod 700 /media/
		echo '**se cambio permisos a root de /media**'
		read -p '**confia en este dispositivo? s/n:... ' sn
		if [ $sn == "s" ]; then 
			chmod 755 /media/
			echo '**confia en este dispositivo :)**'
			exit 0
		fi
		if [ $sn == "n" ]; then 
			udisksctl unmount --force -b /dev/sdb1
			chmod 755 /media/
			echo '**Se desmonto el dispositivo y se restauraron los permisos de /media**'
			exit 0
		fi		
	fi
sleep 3
done

