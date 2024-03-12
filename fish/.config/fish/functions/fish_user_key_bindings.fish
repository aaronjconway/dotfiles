#################################
#--------------------------------
#---------Keybindings------------
#--------------------------------
#################################
function fish_user_key_bindings

  # history
  bind \cr get_history

  # del word on ctrl backspace
  bind \cH backward-kill-path-component

  # lazy git
  bind \cg lazygit

  # find folders with ranger
  bind \cO fzf_telescope

end

#################################
#--------------------------------
#---------functions--------------
#--------------------------------
#################################


# jump back a dir
bind \cj previous_dir
function previous_dir
  prevd
  commandline -f repaint
end

# jump forward a dir
bind \ck next_dir
function next_dir
  nextd
  commandline -f repaint
end


#open vim
bind \cv open_vim
function open_vim
  nvim
end


function find_root_dir
    set current_dir (pwd)

    while test $current_dir != "/"
        if test -e $current_dir/readme.md -o -d $current_dir/.git
            echo "$current_dir"
            return
        end

        set current_dir (dirname $current_dir)
        commandline -f repaint
    end

    # If no root directory is found
    echo "--------------"
    commandline -f repaint
end

function internal_get_history

  history |fzf |read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function internal_directories

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

function internal_all_directories

  # Store the current directory in a variable
  set prev_dir (pwd)
  # Use fzf to select a directory and store the result in the 'foo' variable
  set foo (fdfind . /home/aaron -td -uu --hidden --follow | fzf --preview 'tree -a -C {}')
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


#searches my windows files in ajcon
function internal_windows_directories

  # Store the current directory in a variable
  set prev_dir (pwd)
  # Use fzf to select a directory and store the result in the 'foo' variable
  set foo (fdfind . /mnt/c/Users/ajcon/ | fzf --preview 'tree -a -C {}')
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

#finds files based on /home/aaron
function internal_files
  set prev_dir (pwd)

  while true
    set foo (fdfind . /home/aaron --exclude 'node_modules' --exclude '.local' --exclude '.cache' --exclude '.cargo' -tf --hidden --follow | fzf --preview 'batcat --color=always {}')

    if test -z "$foo"
      cd "$prev_dir"
      break
    else
      commandline -f repaint
      vim "$foo"
    end
  end
end

function internal_all_files
  set prev_dir (pwd)

  while true
    set foo (fdfind . /home/aaron  -tf --hidden --follow | fzf --preview 'batcat --color=always {}')

    if test -z "$foo"
      cd "$prev_dir"
      break
    else
      commandline -f repaint
      vim "$foo"
    end
  end
end

# get's the files in a project based on the find_root_dir function
function internal_project_files

  set prev_dir (pwd)

  while true
    set -l dir (find_root_dir)
    set foo (fdfind . $dir  -tf --hidden --exclude '.cache' --exclude '.cargo' --exclude 'go' --exclude 'node_modules'  --exclude 'dist' --exclude '.git' --follow | fzf --preview 'batcat --color=always {}')

    if test -z "$foo"
      cd "$prev_dir"
      break
    else
      commandline -f repaint
      vim "$foo"
      commandline -f repaint
    end
  end
end

# get's the files in a project WITHOUT exluding any based on the find_root_dir function
function internal_project_files
  # Store the current directory in a variable
  set prev_dir (pwd)

  while true
    # Use fdfind to search for files (including hidden ones) and store the result in 'foo' variable
    set -l dir (find_root_dir)
    set foo (fdfind . $dir  -tf --hidden --exclude '.git' --follow | fzf --preview 'batcat --color=always {}')


    # Check if 'foo' is empty (Esc pressed)
    if test -z "$foo"
      # Go back to the previous directory and exit the loop
      cd "$prev_dir"
      break
    else
      # Open the selected file in Vim and repaint the command line
      commandline -f repaint
      vim "$foo"
      commandline -f repaint
    end
  end
end



# opens a list of commands
function fzf_telescope

  function get_commands

    # Gets all functions, uses the function_id to filter out only functions we want in here, removes the id with sed, sends to printf for new line adding then to fzf

    # the function name space we are filtering on
    set -l function_id 'internal_'
    set -l function_list $(functions | grep -i $function_id | sed "s/$function_id//g" )
    printf '%s\n' $function_list

  end

   # Store the current directory in a variable
   set prev_dir (pwd)

   set -l foo (get_commands | fzf --prompt="Select a command: ")

     if test -n "$foo"
      # have to add back the internal stuff
      # should probably creat a dict, key for func and v for display purposes.

       commandline -f repaint
       set -l name 'internal_'
       set -l func (string join "" $name $foo)
       $func
     else
       commandline -f repaint
       cd "$prev_dir"
     end
end



