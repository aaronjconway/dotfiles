#!/usr/bin/zsh

# Get the selected directory using fzf
directory_path=$(find ~/development -maxdepth 1 -type d | fzf)

# Check if a directory was selected
if [ -z "$directory_path" ]; then
    echo "No directory selected."
    exit 1
fi

# Extract just the folder name from the selected path
directory_name="${directory_path##*/}"

# Start a new tmux session named 'khl'
tmux new-session -d -s khl -n Server

# Create a new window named 'Server' and navigate to the project directory
tmux send-keys -t khl:Server "cd ~/development/$directory_name " C-m
tmux send-keys -t khl:Server C-l
tmux send-keys -t khl:Server "npm run dev" C-m

tmux new-window -t khl -n Dev
tmux send-keys -t khl:Dev "cd ~/development/$directory_name/" C-m
tmux send-keys -t khl:Dev C-l

# Attach to the tmux session
tmux attach -t khl
