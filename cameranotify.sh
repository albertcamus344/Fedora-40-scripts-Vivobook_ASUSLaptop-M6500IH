#!/bin/bash

# Path to the camera state file
CAMERA_STATE_FILE="/etc/your/camerastate.txt"

# Initialize the previous state
previous_state=$(cat "$CAMERA_STATE_FILE")

# Monitor the file for changes
while true; do
    # Wait for the file to change
    inotifywait -e modify "$CAMERA_STATE_FILE"

    # Read the current state
    current_state=$(cat "$CAMERA_STATE_FILE")

    # Check for state changes
    if [[ "$previous_state" -eq 0 && "$current_state" -eq 1 ]]; then
        notify-send "Camera Enabled"
	echo "camera enabled"
    elif [[ "$previous_state" -eq 1 && "$current_state" -eq 0 ]]; then
        notify-send "Camera Disabled"
	echo "camera disabled"
    fi

    # Update the previous state
    previous_state="$current_state"
done
