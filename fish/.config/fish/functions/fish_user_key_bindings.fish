function fish_user_key_bindings
  # historr
  bind \cr fzf_select_history 

  # historr
  bind \cv fish_open_vim 

  # lazy git
  bind \cg lazygit 

  # find files
  bind \cf fzf_find_files

  # find folders with ranger
  bind \cO fzf_find_dir_ranger

end
