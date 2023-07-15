function fzf_find_dir 

  fdfind . /home/aaron -td -E node_modules --follow|fzf --preview 'tree -a -C {}' |read foo

  if test -n $foo
    cd $foo
    commandline -f repaint
  end
end
