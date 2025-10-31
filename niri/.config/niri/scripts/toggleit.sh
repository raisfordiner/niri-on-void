#!/usr/bin/env bash

# ToggleIt.sh - Toggle between two KDL expressions
# Usage: toggleit.sh [file] [NameOfExpression]

set -e

if [ $# -ne 2 ]; then
    echo "Usage: $0 [file] [NameOfExpression]"
    echo "Example: $0 config.kdl Brightness"
    exit 1
fi

FILE="$1"
NAME="$2"

if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found"
    exit 1
fi

# Create a temporary file
TEMP_FILE=$(mktemp)

# Flag to track if we found and toggled the expression
FOUND=0

# Read the file line by line
while IFS= read -r line || [ -n "$line" ]; do
    # Check if this line is a TOGGLEIT comment for our target name
    if [[ "$line" =~ ^[[:space:]]*//[[:space:]]*@TOGGLEIT\[(.*)\]\[(.*)\]${NAME}[[:space:]]*$ ]]; then
        EXPR1="${BASH_REMATCH[1]}"
        EXPR2="${BASH_REMATCH[2]}"
        
        # Write the comment line
        echo "$line" >> "$TEMP_FILE"
        
        # Read the next line (the actual expression)
        IFS= read -r next_line || [ -n "$next_line" ]
        
        # Trim whitespace from next_line for comparison
        trimmed_next=$(echo "$next_line" | xargs)
        trimmed_expr1=$(echo "$EXPR1" | xargs)
        trimmed_expr2=$(echo "$EXPR2" | xargs)
        
        # Toggle based on current value
        if [ "$trimmed_next" = "$trimmed_expr1" ]; then
            echo "$EXPR2" >> "$TEMP_FILE"
            echo "Toggled '$NAME': [$EXPR1] -> [$EXPR2]"
            FOUND=1
        elif [ "$trimmed_next" = "$trimmed_expr2" ]; then
            echo "$EXPR1" >> "$TEMP_FILE"
            echo "Toggled '$NAME': [$EXPR2] -> [$EXPR1]"
            FOUND=1
        else
            # Current line doesn't match either expression, keep as is
            echo "$next_line" >> "$TEMP_FILE"
            echo "Warning: Current value doesn't match either toggle option"
            echo "  Current: [$next_line]"
            echo "  Option 1: [$EXPR1]"
            echo "  Option 2: [$EXPR2]"
            FOUND=1
        fi
    else
        echo "$line" >> "$TEMP_FILE"
    fi
done < "$FILE"

if [ $FOUND -eq 0 ]; then
    echo "Error: Toggle expression '$NAME' not found in file"
    rm "$TEMP_FILE"
    exit 1
fi

# Replace original file with modified version
mv "$TEMP_FILE" "$FILE"

echo "File updated successfully: $FILE"
