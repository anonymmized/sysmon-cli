#!/bin/bash

detectOS() {
    case "$(uname)" in
        Darwin) OS="MacOS" ;;
        Linux) OS="Linux" ;;
        MINGW*|CYGWIN*) OS="MSWin" ;;
        *) OS="Unknown" ;;
    esac
}

detectOS

draw_progress_bar() {
    local -r progress=$(printf "%.0f" $1)
    local -r max_length=10
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

detect_cpu_usage() {
    if [[ "$OS" == "MacOS" ]]; then
        cpu_usage=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
        draw_progress_bar $cpu_usage
    elif [[ "$OS" == "Linux" ]]; then
        cpu_usage=$(vmstat 1 2 | tail -1 | awk '{print 100-$15}')
        draw_progress_bar $cpu_usage
    else
        echo "Unsupported OS: $OS"
    fi
}

echo "Detected OS: $OS"
detect_cpu_usage
