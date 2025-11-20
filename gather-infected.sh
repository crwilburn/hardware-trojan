#!/bin/bash

IMAGE_DIR="1000-images"
RESULTS_CSV="infected-results.csv"

if [ ! -f "RESULTS_CSV" ]; then
    echo "CPU Percent,Latency,Temperature (C)" > "RESULTS_CSV"
fi

for IMAGE in "$IMAGE_DIR"/*; do
    if [ -f "$IMAGE" ]; then
        echo "Processing: $IMAGE"

        RESULTS=$(/usr/bin/time -v python3 auto-classify.py --imagePath "$IMAGE" 2>&1)

	    LATENCY=$(echo "$RESULTS" | grep 'CLASSIFICATION_LATENCY: ' | awk '{print $2}') 
        CPU_USAGE=$(echo "$RESULTS" | grep 'Percent of CPU' | awk -F': ' '{print $2}' | awk '{print $1}')

        TEMP=$(cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null)
        TEMP_C=$(echo "scale=1; $TEMP / 1000" | bc)

        echo "$CPU_USAGE,$LATENCY,$TEMP_C" >> "$RESULTS_CSV"

    fi
done

echo "Processing complete. Results saves to $RESULTS_CSV."
