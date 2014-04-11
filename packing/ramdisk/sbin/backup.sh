if [ -f /mnt/sata/createbackup ]; then
	i=1
	FBSPLASH="/sbin/busybox fbsplash -d /dev/graphics/fb0 -s"
	while [ $i -le 100 ]; do
		if [ ! -d "/mnt/sata/backup/nand${i}" ]; then
			${FBSPLASH} /prg/0.ppm
			echo "none" > /sys/class/leds/green\:ph20\:led1/trigger
			echo "0" > /sys/class/leds/green\:ph20\:led1/brightness
			echo "none" > /sys/class/leds/blue\:ph21\:led2/trigger
			echo "0" > /sys/class/leds/blue\:ph21\:led2/brightness
			/sbin/busybox mkdir -p "/mnt/sata/backup/nand${i}"
			j=1
			for c in a b c d e f g h i j; do
				${FBSPLASH} /prg/${j}.ppm
				/sbin/busybox dd if=/dev/block/nand${c} bs=1M | /sbin/busybox gzip > "/mnt/sata/backup/nand${i}/nand${c}.img.gz"
				#/sbin/busybox sleep 5
				let j=j+1
			done
			${FBSPLASH} /prg/11.ppm
			/sbin/busybox rm -f /mnt/sata/createbackup
			break
		fi
		let i=i+1
	done
fi
