#!/bin/bash

# Usage: ./script.sh "line to add" filename

LINE="$1"
FILE="$2"

# If file doesn't exist, create it
if [ ! -f "$FILE" ]; then
  touch "$FILE"
fi

# Check if the line already exists in the file
if ! grep -Fxq "$LINE" "$FILE"; then
  echo "$LINE" >> "$FILE"
  echo "Line added."
else
  echo "Line already exists."
fi
