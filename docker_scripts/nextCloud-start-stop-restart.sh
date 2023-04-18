#!/bin/bash

containers=("nextCloud-app" "nextCloud-sql")
sleep_time=1

oper=$1

if [[ "$oper" == "stop" ]] || [[  "$oper" == "restart" ]] ; then

	for c in ${containers[@]} ; do
		echo stopping $c
		docker stop $c
		sleep $sleep_time
	done
fi

if [[ "$oper" == "start" ]] || [[  "$oper" == "restart" ]] ; then

	for ((c=${#containers[@]} - 1; c >= 0; c--)) ; do
		echo starting ${containers[$c]}
			docker start ${containers[$c]}
			sleep $sleep_time
	done
fi

docker ps
	

