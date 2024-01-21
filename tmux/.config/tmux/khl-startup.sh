#!/bin/bash

# Start a new tmux session named 'khl'
tmux new-session -d -s khl -n Server

# Create a new window named 'Server' and navigate to the project directory
tmux send-keys -t khl:Server 'cd ~/development/astro-kaseyhomeloans/' C-m
tmux send-keys -t khl:Server C-l
tmux send-keys -t khl:Server 'npm run dev -- --open' C-m

tmux new-window -t khl -n Dev
tmux send-keys -t khl:Dev 'cd ~/development/astro-kaseyhomeloans/' C-m
tmux send-keys -t khl:Dev  C-l

# Attach to the tmux session
tmux attach -t khl

