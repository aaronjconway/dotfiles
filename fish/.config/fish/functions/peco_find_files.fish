function peco_find_files
  if test (count $argv) = 0
    set peco_flags --layout=bottom-up
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end

  fdfind . /home/aaron -td --hidden --follow|peco $peco_flags|read foo

  commandline $foo
  commandline -f execute
end
