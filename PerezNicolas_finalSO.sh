#!/bin/bash

ports=$(lsusb -t | grep -e Class=Human -e Class=Mass -c)
media=$(lsblk | grep -c media)
echo '**Tenes '$media 'USB montados en /media y' $ports 'puertos activos:'
lsusb -t | grep -e Class=Human -e Class=Mass
while [ true ] ; do
	echo '*Esperando dispositivos...'
	if [ $ports != $(lsusb -t | grep -e Class=Human -e Class=Mass -c) ]; then
		echo '**Se introdujo un nuevo dispositivo no listado:'
		lsusb -t | grep -e Class=Human -e Class=Mass
		echo 2-1 |sudo tee /sys/bus/usb/drivers/usb/unbind # bus 2, puerto 1 usb(3.0) -> desactivado
		echo 2-2 |sudo tee /sys/bus/usb/drivers/usb/unbind # bus 2, puerto 2 usb(3.0) -> desactivado
		echo 2-3 |sudo tee /sys/bus/usb/drivers/usb/unbind # bus 2, puerto 3 usb(2.0) -> desactivado
		chmod 700 /media/
		echo '**Se desactivaron todos los puertos USB y se cambio a root los permisos de /media**'
		read -p '**confia en este dispositivo? s/n: ... ' sn
 		if [ $sn == 's' ]; then
			chmod 755 /media/
			echo 2-1 |sudo tee /sys/bus/usb/drivers/usb/bind # bus 2, puerto 1 usb(3.0) -> activado
                        echo 2-2 |sudo tee /sys/bus/usb/drivers/usb/bind # bus 2, puerto 2 usb(3.0) -> activado
       	                echo 2-3 |sudo tee /sys/bus/usb/drivers/usb/bind # bus 2, puerto 3 usb(2.0) -> activado
       			echo '**Los valores fueron restablecidos y el dispositivo montado con exito!**'
			exit 0
		fi
		if [ $sn == 'n' ]; then
			if [ $ports != $(lsusb -t | grep -e Class=Human -e Class=Mass -c) ]; then
				echo '**retire el dispositivo sospechoso antes de restablecer los valores**'
				read -p '**desea reestablecer los valores? REQUERIDO! s/n: ... ' ok
				if [ $ok == 's' ]; then	
					chmod 755 /media/
	                                echo 2-1 |sudo tee /sys/bus/usb/drivers/usb/bind # bus 2, puerto 1 usb(3.0) -> activado
               		                echo 2-2 |sudo tee /sys/bus/usb/drivers/usb/bind # bus 2, puerto 2 usb(3.0) -> activado
                               		echo 2-3 |sudo tee /sys/bus/usb/drivers/usb/bind # bus 2, puerto 3 usb(2.0) -> activado
					echo '**Los valores fueron restablecidos con exito!**'
					exit 0
				else	
					echo '**ERROR FATAL: los valores no fueron restablecidos**'
					exit 1
				fi
			fi
		fi			
	fi		
sleep 3
done
 
