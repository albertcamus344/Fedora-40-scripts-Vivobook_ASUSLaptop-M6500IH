#!/bin/bash

# Path to the control parameter
CTRL_PARAM="/sys/kernel/debug/asus-nb-wmi/ctrl_param"
# Previous value
PREV_VALUE=""

# Function to execute commands based on value change
execute_command() {
    local new_value="$1"
    if [ "$new_value" == "0x00000001" ]; then
        echo "Value changed to 0x00000001, executing command to set bConfigurationValue to 0"
        echo 0 | tee /sys/bus/usb/devices/3-3/bConfigurationValue > /dev/null
	    echo 0 > /etc/your/camerastate.txt
    elif [ "$new_value" == "0x00000000" ]; then
        echo "Value changed to 0x00000000, executing command to set bConfigurationValue to 1"
        echo 1 | tee /sys/bus/usb/devices/3-3/bConfigurationValue > /dev/null
	    echo 1 > /etc/your/camerastate.txt
    fi
}

# Main loop to monitor the control parameter
while true; do
    # Read the current value
    CURRENT_VALUE=$(cat "$CTRL_PARAM")

    # Check if the value has changed
    if [ "$CURRENT_VALUE" != "$PREV_VALUE" ]; then
        # Execute command based on the new value
        execute_command "$CURRENT_VALUE"
        # Update the previous value
        PREV_VALUE="$CURRENT_VALUE"
    fi
done
