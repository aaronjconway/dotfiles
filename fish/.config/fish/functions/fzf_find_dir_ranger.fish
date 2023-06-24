function fzf_find_dir_ranger

  fdfind . /home/aaron -td --hidden --follow|fzf --preview 'tree -a -C {}' |read foo

  cd $foo && ranger
  commandline -f repaint
end
