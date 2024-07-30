#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
KEYS_FILE="./allKeys.txt"
OUTPUT_DIR="./private"

# Create the output directory if it does not exist
mkdir -p "$OUTPUT_DIR"

# Initialize line number counter
i=0

# Read the keys file line by line
while IFS= read -r key; do
    # Increment the line number counter
    i=$((i + 1))
    
    # Generate a unique filename based on the line number
    FILE_NAME=$(printf "key_%04d.json" "$i")
    
    # Create a JSON file with the private key content directly
    echo "$key" > "$OUTPUT_DIR/$FILE_NAME"
    
    echo "Created $OUTPUT_DIR/$FILE_NAME"
done < "$KEYS_FILE"

echo "All keys have been processed."
