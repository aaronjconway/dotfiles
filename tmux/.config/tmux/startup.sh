#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

# Start a new tmux session named 'khl'
tmux new-session -d -s khl -n Server

# Create a new window named 'Server' and navigate to the project directory
tmux send-keys -t khl:Server "cd ~/development/$directory_path/" C-m
tmux send-keys -t khl:Server C-l
tmux send-keys -t khl:Server "npm run dev -- --open" C-m

tmux new-window -t khl -n Dev
tmux send-keys -t khl:Dev "cd ~/development/$directory_path/" C-m
tmux send-keys -t khl:Dev C-l

# Attach to the tmux session
tmux attach -t khl
