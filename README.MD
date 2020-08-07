lsusb -- lista puertos y buses de usb y dispositivos
ls -l /dev/sd* --- lista todas las memorias y particiones
mount -t vfat // ntfs-3g // ext4 /particion /ruta de montaje.
unmont /ruta de montaje
/media/user -- montaje del usb

IMPORTANTE!!! lsblk -x NAME| grep media -- lista los dispositivos de almacenamiento USB por nombre
              lsblk | grep - c media -- cantidad de usb conectados
              
$ udisksctl unmount --force -b /dev/sd*1

ME DIJO AGUS QUE INVESTIGUE: 

		-udev  -> no viene instalado
		-udisk
		-como bloquear el automount
		-dmesg (muestra muuuuuucha info.. muuuuucha)
		
Bus 02 - ports 1 y 2 -> usb 3.0
       - ports 3 -> usb 2.0
 
 * lsusb -t | grep -e Class=Human -e Class=Mass -> me trae info de los puertos usb
 
* echo 'bus-port' |sudo tee /sys/bus/usb/drivers/usb/unbind  -- desmonta
* echo 'bus-port' |sudo tee /sys/bus/usb/drivers/usb/bind    -- monta

 
