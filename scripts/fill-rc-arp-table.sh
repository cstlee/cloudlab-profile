#! /bin/bash

RC_HOSTS_FILE=$1

HOSTS=($(cat $RC_HOSTS_FILE | tr '\n' ' '))

for HOST in ${HOSTS[@]}
do
	ping -c 1 $HOST 2>&1 >/dev/null
done
