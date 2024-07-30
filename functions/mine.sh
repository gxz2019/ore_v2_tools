#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Source the configuration script
source ./config.sh

# Check if required variables are set
if [[ -z "$ORE_CLI" || -z "$KEYS_DIR" ]]; then
    echo "Please set ORE_CLI, and KEYS_DIR in config.sh."
    exit 1
fi

# Define additional variables
PRIORITY_FEE="<MICROLAMPORTS>"
THREAD_COUNT="<THREAD_COUNT>"

# Check if additional variables are set
if [[ -z "$PRIORITY_FEE" || -z "$THREAD_COUNT" ]]; then
    echo "Please set PRIORITY_FEE and THREAD_COUNT."
    exit 1
fi

# Initialize array to hold PIDs
pids=()

# Process each keypair file in the keys directory
for KEYPAIR_FILE in "$KEYS_DIR"/*.json; do
    # Generate the ore command
    COMMAND="${COMMON_COMMAND} $KEYPAIR_FILE --priority-fee $PRIORITY_FEE mine --threads $THREAD_COUNT"
    
    # Execute the ore command in the background
    echo "Executing ore command for keypair $(basename "$KEYPAIR_FILE")..."
    eval $COMMAND &
    
    # Capture the PID of the last background process
    pids+=($!)
    
    echo "Started mining for keypair $(basename "$KEYPAIR_FILE")"
done

# Wait for all background processes to finish
echo "Waiting for all background processes to complete..."
for pid in "${pids[@]}"; do
    wait $pid
done

echo "Batch mining process complete!"
