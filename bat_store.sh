#!/bin/bash

# Set the file to monitor and the output file
INPUT_FILE=/sys/class/power_supply/BAT0/charge_control_end_threshold
OUTPUT_FILE=/etc/your/bat_persist.txt

# Monitor the file for changes
while inotifywait -e modify $INPUT_FILE; do
  # Get the new value
  NEW_VALUE=$(cat $INPUT_FILE)

  # Write the new value to the output file
  echo $NEW_VALUE > $OUTPUT_FILE
done
