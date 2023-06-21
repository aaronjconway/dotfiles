function fzf_find_dir 

  fdfind . /home/aaron -td --hidden --follow|fzf --preview 'tree -a -C {}' |read foo

  cd $foo
  commandline -f repaint
end
