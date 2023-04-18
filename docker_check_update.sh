#!/bin/bash

info_file="/adm/info/docker_pull.log"

CONTAINES_MONITORED=2
UP_TO_DATE=0

function pullDockerImages {
    for f in $(docker image ls | grep latest | awk {'print $1'}) ; do 
        docker pull $f 
    done
}


function sentPtsMessage {
    for f in $(ls /dev/pts/) ; do 
        echo -e "\n\r${1}\r" >> /dev/pts/$f
    done
}

pullDockerImages > /dev/null

UP_TO_DATE=$((UP_TO_DATE +$(docker container ls | grep nextCloud | grep latest -c)))

if [[ "$UP_TO_DATE" != "$CONTAINES_MONITORED" ]] ; then
    msg="SOME CONTAINERS ARE NOT UP TO DATE (${UP_TO_DATE}/${CONTAINES_MONITORED})"
    echo $msg > $info_file
    sentPtsMessage "$msg"
else
    rm -f $info_file
fi