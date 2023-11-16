#!/bin/bash

PATH_UJ=/sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/energy_uj
CURR_UJ=`cat ${PATH_UJ}`
MIL=1000000
HOSTNAME=`hostname`
BUCKET=telegraf
ORG=xDots
TOKEN=-HlBuFRpvFCO82dTtB6aMuWkoxc1UOYtn1tBBcc_QaB-uK7CmH8wvAlaP-zs8x_uathHPRIKQGsv1UIcx-uGxQ==
NUMBER=0

sleep 1

while :
do
	PREV_UJ=$CURR_UJ
	CURR_UJ=`cat /sys/devices/virtual/powercap/intel-rapl/intel-rapl:0/energy_uj`
	DELTA=$(expr $CURR_UJ - $PREV_UJ)
	WATT=$(echo "scale=2; $DELTA / $MIL" | bc)

	if [ ${NUMBER} -gt 4 ]
	then
		if [ ${WATT} -gt 0 ]
		then
			influx write -b ${BUCKET} -o ${ORG} -t=${TOKEN} 'wattmon,host='${HOSTNAME}' watt='${WATT}
		fi
		NUMBER=0
	fi

	((NUMBER++))

	sleep 1
done
