#!bin/bash
aux=0
if [ $(lsblk | grep -c media) == 0 ]; then
	cont=$(lsusb -t | grep -c Port)
	echo 'hay ' $cont 'cantidad de puertos'
	while [ $aux == 0 ]; do
		if [ $cont != $(lsusb -t | grep -c Port) ]; then
			echo 'Se encontro: '$(lsusb -t | grep Mass)	
			chmod 700 /media/
			echo 'Se cambiaron los permisos de /media a root'
			#umount -f /dev/sdb1
			udisksctl unmount --force -b /dev/sdb1
			read -p '**confia en este dispositivo? s/n:... ' sn
			if [ $sn == "s" ]; then
        	        	chmod 755 /media/
                	        echo '**confia en este dispositivo :)**'
                        	mount -t vfat /dev/sdb1 /media/
                       		echo '**USB montado con exito!**'
                        	exit 0
			fi

			if [ $sn == "n" ]; then
                        	chmod 755 /media/
                        	echo '**Se restauraron los permisos de /media**'
                        	exit 0
			fi
		fi 

	sleep 3
	done

else
                udisksctl unmount --force -b /dev/sdb1
		echo 'Habia un USB que fue desmontado'
fi	
