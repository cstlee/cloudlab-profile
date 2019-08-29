#! /bin/bash

RC_HOSTS_FILE=$1

for RC_HOSTNAME in $(cat $RC_HOSTS_FILE)
do
    PUBLIC_HOSTNAME=`ssh $RC_HOSTNAME "hostname -A" | awk '{print $1}'`
    echo "$RC_HOSTNAME $PUBLIC_HOSTNAME"
done

