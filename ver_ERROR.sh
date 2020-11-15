#!/bin/bash

file_log='log.txt'
threshold=20

number_line=$(cat $file_log  | wc -l)

#echo $number_line

#last_line=$(echo $number_line | awk '{print $1 + 1}')

first_line=$(cat number_line )
last_line=$(wc -l $file_log | awk '{print $1}' )

#echo $first_line $number_line

cat log.txt | awk -v f_n="$first_line" -v l_n="$last_line" 'NR>=f_n && NR<=l_n {print $0}' > _log.txt

ssum=$(cat _log.txt  | grep -i ERROR: | wc -l)

if [ $ssum -gt $threshold ]
then
    #echo [$(date '+%Y-%m-%d')]:[$(date '+%H:%M:%S')] "[A L E R T A] :: Se han detectado " $ssum " Errores en el ultimo monitoreo"
    sudo telegram-send  "[$(date '+%Y-%m-%d')]:[$(date '+%H:%M')] [A L E R T A] :: Se han detectado $ssum Errores en el ultimo monitoreo"

    echo "[$(date '+%Y-%m-%d')]:[$(date '+%H:%M')] [A L E R T A] :: Se ha ejecutado telegram" >> xxlog.txt

else

	echo "[$(date '+%Y-%m-%d')]:[$(date '+%H:%M')] [A L E R T A] :: NO -- Se ha ejecutado telegram" >> xxlog.txt

fi

#----------------------------

echo $number_line | awk '{print $1 + 1}' > number_line

last_line=$(cat number_line )

#echo $last_line

#----------------------------

