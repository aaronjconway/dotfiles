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


function fzf_select_history

  history|fzf |read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

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

