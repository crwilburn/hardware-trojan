#!/bin/bash

IMAGE_DIR="test-images"


for IMAGE in "$IMAGE_DIR"/*; do
    if [ -f "$IMAGE" ]; then
        echo "Processing: $IMAGE"

        RESULTS=$(/usr/bin/time -v python3 classify.py --imagePath "$IMAGE" 2>&1)



    fi
done


