#!/bin/bash

host=$1
hostport=$2
hostuser=$3
tunnelport=$4

netstatLog=$(netstat -an | grep $host:$hostport)

if [[ $netstatLog == *'ESTABLISHED'* ]]
then
    echo $(date) " TUNNEL READY"
else
    echo $(date) " OPENING TUNNEL"
    # p - port
    # N - do not execute commands
    # R - create tunnel
    ssh -N -p $hostport -R $tunnelport:localhost:$hostport $hostuser@$host &
fi