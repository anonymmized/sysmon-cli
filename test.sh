#!/bin/bash

draw_progress_bar() { 
    local -r progress=$(printf "%.0f" $1)  # округление
    local -r max_length=10  # количество символов в баре
    local bar=''

    for ((i=0; i<max_length; i++)); do
        if [ $i -lt $((progress * max_length / 100)) ]; then
            bar+='█'
        else
            bar+='░'
        fi
    done

    echo -e "CPU Usage: [$bar] $progress%"
}

cpu_usage=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
draw_progress_bar $cpu_usage

# get_cpu_usage() {
#     cpu_usage=$(top -l 1 -n 0 | grep "CPU usage")
    
# }
# get_cpu_usage
# echo $cpu_usage