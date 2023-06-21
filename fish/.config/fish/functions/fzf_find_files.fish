function fzf_find_files

  fdfind . /home/aaron -tf --hidden --follow | fzf --preview 'batcat --color=always {}' |read foo
 
  if test $foo
    vim $foo
    commandline -f repaint
  end
end
