#!/bin/bash

LUZ="/sys/class/leds/input3::capslock/"

for i in {1..5}
do
    echo 1 | sudo tee "${LUZ}brightness" 
    sleep 0.5
    echo 0 | sudo tee "${LUZ}brightness"
    sleep 0.5
done
