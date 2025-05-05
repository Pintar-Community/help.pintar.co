#!/bin/bash

CURRENT_DIR="docs/skills"

cd "$CURRENT_DIR" 

echo "List directory:"

# Exclude dot directories
find . -type d | grep -vE '^\./\.' | while read -r DIR; do
    # Get the directory name without the leading './' or '.'
    # Skip root directory or if it starts with dot
    if [ "$DIR" = "." ] || [[ "$DIR" =~ ^\./\. ]]; then
      continue
    fi
    
    DIR_NAME="${DIR#./}"
    
    # Check if the directory is empty
    if [ -z "$(ls -A "$DIR_NAME")" ]; then
        echo "Directory $DIR_NAME is empty."
        # Uncomment the next line to remove the empty directory
        # rmdir "$DIR_NAME"
    else
        echo "Directory $DIR_NAME is not empty."

        echo "List of files in $DIR_NAME:"
        # List files in the directory
        find "$DIR_NAME" -type f -name "*.md" | while read -r FILE; do
            filename=$(basename "$FILE")

            echo "Removed file: $FILE"
            rm "$FILE"

            echo "Move new one: $filename"
            mv $filename "$DIR_NAME"
        done
    fi
done