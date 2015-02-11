#!/bin/bash

# check option
if [[ $1 == "listen" ]]
then
    # LISTEN
    # check if port is open
    port=$2
    netstatLog=$(netstat -an | grep $port);

    if [[ $netstatLog == *'LISTEN'* ]]
    then
        echo $(date)  " NC ALREADY LISTENING";
    else
        echo $(date)  " NC STOPPED -> STARTING";
        # start nc in background, redirect stdout to logfile
        # l - listen
        # vv - very verbose
        # k - listen again after connection
        # d - don't listen to stdin - required for background operation
        nc -vv -l -k -d $port &>> nclog &
    fi
else
    # CALL
    if [[ $1 == "call" ]]
    then
        host=$2
        port=$3
        name=$4
        myip=$(curl http://curlmyip.com 2> /dev/null)
        # read my public ip and call
        echo $(date) $name CALLING FROM $myip | nc $host $port
    else
        # HELP
        echo 'Example usage:'
        echo 'listen <port>'
        echo 'call <host> <port> <client id>'
    fi
fi
