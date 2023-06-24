function fzf_select_man

  ls /usr/bin | fzf | man foo

  if [ $foo ]
    echo $foo
  else
    commandline 'problem'
  end
end
