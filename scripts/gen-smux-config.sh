#! /bin/bash

RC_HOSTS_FILE=$1

echo "PANES_PER_WINDOW = $(wc -l < $RC_HOSTS_FILE)"
echo "LAYOUT = tiled"

while read HOST; do
	echo "------"
    HOST_PUBLIC_IP=`geni-get manifest | grep $HOST | egrep -o "ipv4=.*" | cut -d'"' -f2`
    echo "ssh $HOST_PUBLIC_IP"
done < $RC_HOSTS_FILE

