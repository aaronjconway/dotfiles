function fzf_select_history

  history|fzf |read foo

  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
