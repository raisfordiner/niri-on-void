#!/bin/sh

# Audio Control Script using pactl
# Usage: ./audio_control.sh [option] [percentage]

show_usage() {
    echo "Usage: $0 [OPTION] [PERCENTAGE]"
    echo ""
    echo "Options:"
    echo "  inc [%]        Increase speaker volume by percentage (e.g., inc 10)"
    echo "  dec [%]        Decrease speaker volume by percentage (e.g., dec 5)"
    echo "  mute           Toggle speaker mute"
    echo "  toggle         Toggle speaker mute (alias for mute)"
    echo "  mic-inc [%]    Increase microphone volume by percentage"
    echo "  mic-dec [%]    Decrease microphone volume by percentage"
    echo "  mic-mute       Toggle microphone mute"
    echo ""
    echo "Examples:"
    echo "  $0 inc 10      # Increase speaker volume by 10%"
    echo "  $0 dec 5       # Decrease speaker volume by 5%"
    echo "  $0 mute        # Toggle speaker mute"
    echo "  $0 mic-inc 15  # Increase mic volume by 15%"
    echo "  $0 mic-dec 8   # Decrease mic volume by 8%"
    echo "  $0 mic-mute    # Toggle microphone mute"
}

# Check if pactl is available
if ! command -v pactl >/dev/null 2>&1; then
    echo "Error: pactl command not found. Please install PulseAudio."
    exit 1
fi

# Function to validate percentage input
validate_percentage() {
    if [ -z "$1" ]; then
        echo "Error: Percentage value required"
        show_usage
        exit 1
    fi
    
    # Check if it's a valid number
    case "$1" in
        ''|*[!0-9]*) 
            echo "Error: Invalid percentage value '$1'. Please use a number (0-100)"
            exit 1
            ;;
        *)
            if [ "$1" -gt 100 ] || [ "$1" -lt 1 ]; then
                echo "Error: Percentage must be between 1 and 100"
                exit 1
            fi
            ;;
    esac
}

case "$1" in
    "inc")
        validate_percentage "$2"
        echo "Increasing speaker volume by $2%..."
        pactl set-sink-volume @DEFAULT_SINK@ "+$2%"
        ;;
    "dec")
        validate_percentage "$2"
        echo "Decreasing speaker volume by $2%..."
        pactl set-sink-volume @DEFAULT_SINK@ "-$2%"
        ;;
    "mute"|"toggle")
        echo "Toggling speaker mute..."
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    "mic-inc")
        validate_percentage "$2"
        echo "Increasing microphone volume by $2%..."
        pactl set-source-volume @DEFAULT_SOURCE@ "+$2%"
        ;;
    "mic-dec")
        validate_percentage "$2"
        echo "Decreasing microphone volume by $2%..."
        pactl set-source-volume @DEFAULT_SOURCE@ "-$2%"
        ;;
    "mic-mute")
        echo "Toggling microphone mute..."
        pactl set-source-mute @DEFAULT_SOURCE@ toggle
        ;;
    "-h"|"--help"|"help"|"")
        show_usage
        ;;
    *)
        echo "Error: Unknown option '$1'"
        echo ""
        show_usage
        exit 1
        ;;
esac
