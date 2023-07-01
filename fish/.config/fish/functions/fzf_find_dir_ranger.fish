function fzf_find_dir_ranger

  fdfind . /home/aaron -td --hidden --follow|fzf --preview 'tree -a -C {}' |read foo


  if test $foo
    cd $foo
    commandline -f repaint
  end
end
