#!/bin/bash

show_header() {
    echo "=================================="
    echo "🖥️  System Health Monitor"
    echo "=================================="
}

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
    local -r label="$2"
    local -r max_length=10
    local bar=''
    for ((i=0; i<max_length; i++)); do
        if [ $i -lt $((progress * max_length / 100)) ]; then
            bar+='█'
        else
            bar+='░'
        fi
    done
    echo -e "$label: [$bar] $progress%"
}

detect_cpu_usage() {
    if [[ "$OS" == "MacOS" ]]; then
        cpu_usage=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
        draw_progress_bar $cpu_usage "CPU usage: "
    elif [[ "$OS" == "Linux" ]]; then
        cpu_usage=$(vmstat 1 2 | tail -1 | awk '{print 100-$15}')
        draw_progress_bar $cpu_usage "CPU usage: "
    else
        echo "Unsupported OS: $OS"
    fi
}

detect_memory_usage() {
    if [[ "$OS" == "MacOS" ]]; then
        memory_usage=$(top -l 1 -s 0 | grep PhysMem | awk '{
            used = $2; unused = $6;
            gsub(/G/, "", used); gsub(/M/, "", unused);
            used_gb = used; unused_mb = unused;
            total_gb = used_gb + (unused_mb/1024);
            usage = (used_gb / total_gb) * 100;
            printf "%.0f", usage;
        }')
        draw_progress_bar $memory_usage "Memory usage: "
    elif [[ "$OS" == "Linux" ]]; then
        memory_usage=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
        draw_progress_bar $memory_usage "Memory usage: "
    else
        echo "Unsupported OS: $OS"
    fi
}

detect_disk_usage() {
    if [[ "$OS" == "MacOS" ]]; then
        disk_usage=$(df -h | grep "/System/Volumes/Data$" | head -1 | awk '{print $5}' | sed 's/%//')
        if [[ -z "$disk_usage" ]]; then
            disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
        fi
    elif [[ "$OS" == "Linux" ]]; then
        disk_usage=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    fi
    draw_progress_bar $disk_usage "Disk Usage"
}

show_top_processes() {
    echo ""
    echo "Top 5 processes:"
    ps aux | sort -nr -k 3 | head -5 | awk '{
        split($11, a, "/"); 
        printf "   %-12s %5s%%\n", a[length(a)], $3
    }'
}
show_header
echo "Detected OS: $OS"
detect_cpu_usage
detect_memory_usage
detect_disk_usage
show_top_processes