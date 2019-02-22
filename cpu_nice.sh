#!/bin/bash

cpu_amount=$(cat /proc/cpuinfo | grep 'cpu cores' | uniq -d | tr -d 'cpu cores\t: ')
echo "Number of CPU to use: $cpu_amount"

{ start1=$(date '+%s');
 echo "Process 1 start: $(date '+%Mmin %Ssec')" | tee -a log1 ;
 nice -19 openssl speed rsa -multi ${cpu_amount} 1>/dev/null 2>/dev/null | tee -a log1 && echo "process 1 stop: $(date '+%Mmin %Ssec')" | tee -a log1;
 stop1=$(date '+%s');
 echo "Process 1 duration(nice 19): $(( stop1 - start1 ))sec" ;
 exit 0; } &
 { start2=$(date '+%s');
 echo "Process 2 start: $(date '+%Mmin %Ssec')" | tee -a log2 ;
 nice --20 openssl speed rsa -multi ${cpu_amount} 1>/dev/null 2>/dev/null | tee -a log2 && echo "Process 2 stop: $(date '+%Mmin %Ssec')" | tee -a log2 ;
 stop2=$(date '+%s'); echo "Process 2 duration(nice -20): $(( stop2 - start2 ))sec" ;
 exit 0; } &
