#!/sbin/busybox sh
AWK="/sbin/busybox awk"
HEAD="/sbin/busybox head"
DD="/sbin/busybox dd"
FBSPLASH="/sbin/busybox fbsplash -d /dev/graphics/fb0 -s"
MKDIR="/sbin/busybox mkdir"
GZIP="/sbin/busybox gzip"
KILL="/sbin/busybox kill"
ECHO"/sbin/busybox echo"
CAT="/sbin/busybox cat"
RM="/sbin/busybox rm"
if [ -f /mnt/sata/createbackup ]; then
	i=1
	while [ $i -le 100 ]; do
		if [ ! -e "/mnt/sata/backup/nand${i}" ]; then
			${FBSPLASH} /prg/0.ppm
			${ECHO} "none" > /sys/class/leds/green\:ph20\:led1/trigger
			${ECHO} "0" > /sys/class/leds/green\:ph20\:led1/brightness
			${ECHO} "none" > /sys/class/leds/blue\:ph21\:led2/trigger
			${ECHO} "0" > /sys/class/leds/blue\:ph21\:led2/brightness
			( ${DD} if=/dev/nand bs=1M 2>dout & ${ECHO} $! >&3 )  3>pid | ${GZIP} > "/mnt/sata/backup/nand${i}.img.gz"
			PID=$(${CAT} pid)
			while kill -0 $PID 2> /dev/null; do
				${ECHO} -n '' > dout
				${KILL} -USR1 $PID
				STAT=$(${CAT} dout | ${HEAD} -n1 | ${AWK} -F "+" '{ print $1 }')
				if [ "$STAT" -lt "400" ]; then
					${FBSPLASH} /prg/1.ppm
				elif [ "$STAT" -lt "800" ]; then
					${FBSPLASH} /prg/2.ppm
				elif [ "$STAT" -lt "1200" ]; then
					${FBSPLASH} /prg/3.ppm
				elif [ "$STAT" -lt "1600" ]; then
					${FBSPLASH} /prg/4.ppm
				elif [ "$STAT" -lt "2000" ]; then
					${FBSPLASH} /prg/5.ppm
				elif [ "$STAT" -lt "2400" ]; then
					${FBSPLASH} /prg/6.ppm
				elif [ "$STAT" -lt "2800" ]; then
					${FBSPLASH} /prg/7.ppm
				elif [ "$STAT" -lt "3200" ]; then
					${FBSPLASH} /prg/8.ppm
				elif [ "$STAT" -lt "3600" ]; then
					${FBSPLASH} /prg/9.ppm
				elif [ "$STAT" -lt "4000" ]; then
					${FBSPLASH} /prg/10.ppm
				fi
			done
#			j=1
#			for c in a b c d e f g h i j; do
#				${FBSPLASH} /prg/${j}.ppm
#				${DD} if=/dev/block/nand${c} bs=1M | /sbin/busybox gzip > "/mnt/sata/backup/nand${i}/nand${c}.img.gz"
#				#/sbin/busybox sleep 5
#				let j=j+1
#			done
			${FBSPLASH} /prg/11.ppm
			${RM} -f /mnt/sata/createbackup
			break
		fi
		let i=i+1
	done
fi
