#!/bin/bash

# Automatically sets up monitor brightness depending on the time of the day
# Depends on ddcutil
# Current ddcutil detect @ 10/2021
# Display 1
#    I2C bus:             /dev/i2c-3
#    EDID synopsis:
#       Mfg id:           GSM
#       Model:            25UM58G
#       Serial number:
#       Manufacture year: 2015
#       EDID version:     1.3
#    VCP version:         2.1
#
# Display 2
#    I2C bus:             /dev/i2c-5
#    EDID synopsis:
#       Mfg id:           GSM
#       Model:            LG ULTRAWIDE
#       Serial number:
#       Manufacture year: 2016
#       EDID version:     1.4
#    VCP version:         2.1

# Gets time of the day, only full hour
time=$(date +"%H")

# if between 0700h - 2100h
if [[ $time -gt 7 ]] && [[ $time -lt 21 ]]
then
    if [[ $time -gt 12 ]] && [[ $time -lt 18 ]]
    then
        # high brightness
        ddcutil --bus=3 setvcp 10 40 &
        ddcutil --bus=5 setvcp 10 35 &
        wait
    else
        #medium brightness
        ddcutil --bus=3 setvcp 10 30 &
        ddcutil --bus=5 setvcp 10 25 &
        wait
    fi
else
    # low brightness
    ddcutil --bus=3 setvcp 10 15 &
    ddcutil --bus=5 setvcp 10 10 &
    wait
fi

