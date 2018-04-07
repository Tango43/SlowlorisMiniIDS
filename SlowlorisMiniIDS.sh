#!/bin/bash
while true
do
        netstat -ntu -4 -6 |  awk '/^tcp/{ print $5 }' | sed -r 's/:[0-9]+$//' | sort | uniq -c | sort -n >> log
        for lines in /home/ogi/log
        do
                conmount="$(awk '{print $1}' "$lines" | bc)"
                conmountint=$(($conmount + 0))
                        if (( $conmountint > 1 ))
                        then
                                echo "Alert Something is wrong" >> alertlog
                        fi
        sleep 5
        rm log #quickfix for not filling up the log file and recreating same alerts on previously started alerts
        done
done
