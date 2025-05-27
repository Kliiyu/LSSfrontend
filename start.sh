#!/bin/bash

cd "$(dirname "$0")"

echo "Installing npm dependencies..."
npm install

if ! command -v screen &> /dev/null; then
    echo "Screen is not installed. Installing screen..."
    if command -v apt &> /dev/null; then
        sudo apt update
        sudo apt install -y screen
    elif command -v yum &> /dev/null; then
        sudo yum install -y screen
    elif command -v apk &> /dev/null; then
        sudo apk add screen
    else
        echo "Cannot install screen automatically. Please install it manually."
        exit 1
    fi
fi

if screen -list | grep -q "LSS"; then
    echo "A screen session for LSS is already running."
    echo "To attach to it, use: screen -r LSS"
    exit 0
fi


echo "Starting LSS in a screen session..."
screen -dmS LSS bash -c "npm run dev -- --host; exec bash"

echo "LSS server is now running in a screen session named 'LSS'."
echo "To attach to the session, use: screen -r LSS"
echo "To detach from the session once attached, press Ctrl+A followed by D"
