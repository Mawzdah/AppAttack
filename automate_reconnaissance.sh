#!/bin/bash

#source the run_tools.sh script to use its functions
source run_tools.sh
source utilities.sh
#Define the log file location
LOG_FILE="$HOME/automated_scan.log"

>$LOG_FILE

# Function to validate IP address
validate_ip() {
    local ip="$1"
    # Check if the input matches the pattern for an IPv4 address
    if [[ $ip =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        # Check if each octet is between 0 and 255
        for octet in $(echo "$ip" | tr '.' ' '); do
            if ((octet < 0 || octet > 255)); then
                return 1
            fi
        done
        return 0
    else
        return 1
    fi
}

# Function to validate port
validate_port() {
    local port="$1"
    # Check if the port is a number between 1 and 65535
    if [[ $port =~ ^[0-9]+$ ]] && ((port >= 1 && port <= 65535)); then
        return 0
    else
        return 1
    fi
}

# Run automated scans - REMOVED AUTOMATIC EXECUTION
# run_automated_scan()