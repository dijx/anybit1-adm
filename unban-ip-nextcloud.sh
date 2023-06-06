#!/bin/bash

source_dir='/opt/docker/mount/nextCloud/app/var_www_html/data/dx/files/Documents'
source_file='unban*_*ip.txt'
unban_command="/usr/bin/fail2ban-client unban"
logfile=/var/log/nextcloud-unban.log

function writeLog {
    time=$(date +%Y-%m-%d" "%H:%M:%S)
    echo "$time $1" >> $logfile
}

for f in $(ls ${source_dir}${source_file} 2>/dev/null) ; do 
    if [[ $(grep -ic "^ok" $f) == 0 ]] ; then

        o_status="OK "

        for i in $(cat $f) ; do 
            #i=$(echo $i | xargs)
            writeLog "File: ${f}, found IP: $i, calling ${unban_command}"
            status=$($unban_command $i)
            o_status+="$status"
            writeLog "${unban_command} return code for $i: ${status}"
        done
        
        echo $o_status > "${f}"

    fi
done


