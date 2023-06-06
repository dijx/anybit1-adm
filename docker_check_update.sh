#!/bin/bash

info_file="/adm/info/docker_pull.log"

CONTAINES_MONITORED=("nextcloud:26.0.1" "mysql:latest")
UP_TO_DATE=0

function pullDockerImages {	
	
	/adm/bin/q: dpull

}



function sentPtsMessage {
    for f in $(ls /dev/pts/) ; do 
        echo -e "\n\r${1}\r" >> /dev/pts/$f
    done
}

pullDockerImages > /dev/null

for f in ${CONTAINES_MONITORED[@]} ; do
    (( UP_TO_DATE=$UP_TO_DATE +$(docker container ls | grep $f -c) ))
done

if [[ "$UP_TO_DATE" != "${#CONTAINES_MONITORED[@]}" ]] ; then
    msg="SOME CONTAINERS ARE EITHER NOT RUNNING OR NOT UP TO DATE (${UP_TO_DATE}/${#CONTAINES_MONITORED[@]})"
    echo $msg > $info_file
    sentPtsMessage "$msg"
else
    rm -f $info_file
fi
