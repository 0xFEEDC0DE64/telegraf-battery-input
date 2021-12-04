#!/bin/bash

for i in /sys/class/power_supply/BAT*
do
    battery="$(basename $i)"

    printf "power_supply,dev=%s " "$battery"

    FIRST_ONE=1
    for j in cycle_count energy_full energy_full_design energy_now power_now voltage_now
    do
        if [[ $FIRST_ONE -eq 1 ]]
        then
            FIRST_ONE=0
        else
            printf ","
        fi

         printf "%s=%s" "$j" "$(cat $i/$j)"
    done

    printf "\n"
done
