function fzf_find_files
  # Store the current directory in a variable
  set prev_dir (pwd)

  while true
    # Use fdfind to search for files (including hidden ones) and store the result in 'foo' variable
    set foo (fdfind . /home/aaron --exclude 'node_modules' --exclude '.local' --exclude '.cache' --exclude '.cargo' -tf --hidden --follow | fzf --preview 'batcat --color=always {}')

    # Check if 'foo' is empty (Esc pressed)
    if test -z "$foo"
      # Go back to the previous directory and exit the loop
      cd "$prev_dir"
      break
    else
      # Open the selected file in Vim and repaint the command line
      vim "$foo"
      commandline -f repaint
    end
  end
end

