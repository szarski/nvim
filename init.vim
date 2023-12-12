  call plug#begin()
    Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
    Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
    Plug 'romgrk/barbar.nvim'
  call plug#end()

  " normal mode
  nmap <C-l> :bn <CR>
  nmap <C-h> :bp <CR>
  nmap <C-m> :bd <CR>

  map <C-j> 5j
  map <C-k> 5k

  " command mode
  cnoremap <C-a> <Home>
  cnoremap <C-d> <Delete>
  cnoremap <C-e> <End>
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>

  " use system clipboard
  set clipboard+=unnamedplus

  " replace tabs with spaces
  set shiftwidth=4 smarttab
  set expandtab
  set tabstop=8 softtabstop=0

  " make C-e open :e current-dir
  nmap <expr> <C-e> Elocal()
  function! Elocal ()
    let dir = getcwd()
    return ":e " . expand('%:p:h') . "/"
  endfunction
