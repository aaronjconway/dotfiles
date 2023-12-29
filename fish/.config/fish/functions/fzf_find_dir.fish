function fzf_find_dir
  # Store the current directory in a variable
  set prev_dir (pwd)

  # Use fzf to select a directory and store the result in the 'foo' variable
  set foo (fdfind . /home/aaron -td --exclude '.cache' --exclude '.cargo' --exclude 'go' --exclude 'node_modules' --hidden --follow | fzf --preview 'tree -a -C {}')

  # Check if 'foo' is empty (Esc pressed)
  if test -z "$foo"
    # Go back to the previous directory
    cd "$prev_dir"
  else
    # Change to the selected directory and repaint the command line
    cd "$foo"
    commandline -f repaint
  end
end
