function fish_user_key_bindings
  # histor
  bind \cr fzf_select_history 
  
  bind \t accept-autosuggestion
  bind \cH backward-kill-path-component

  # histor
  bind \cv fish_open_vim 


  # lazy git
  bind \cg lazygit 

  # find files
  bind \cf fzf_find_files

  # find folders with ranger
  bind \cO fzf_find_dir 

end
