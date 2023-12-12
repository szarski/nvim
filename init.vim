let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

call plug#begin()
  Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
  Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
  Plug 'romgrk/barbar.nvim'
  Plug 'preservim/nerdtree'
  Plug 'airblade/vim-rooter'

  " Stuff for Elixir LSP
  Plug 'hrsh7th/nvim-cmp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'neovim/nvim-lspconfig'
call plug#end()
PlugInstall | quit

" " normal mode
" nmap <C-l> :bn <CR>
" nmap <C-h> :bp <CR>
" nmap <C-m> :bd <CR>

map <C-j> 5j
map <C-k> 5k

" barbar mappings
nnoremap <silent>    <C-l> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-h> <Cmd>BufferNext<CR>
nnoremap <silent>    <C-m> <Cmd>BufferClose<CR>

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
set shiftwidth=2 smarttab
set expandtab
set tabstop=8 softtabstop=0

" make C-e open :e current-dir
nmap <expr> <C-e> Elocal()
function! Elocal ()
  let dir = getcwd()
  return ":e " . expand('%:p:h') . "/"
endfunction

" NERDTree
:so $HOME/.config/nvim/config/NERDTree_config.vim
nmap <Esc><Esc> :call SmartToggleNerdTree() <CR>

" start in workspace dir
cd $HOME/workspace

" enable line nubmers
set number

" disable coursor animation
let g:neovide_cursor_animation_length = 0

" color coursor, selection and overlength content
highlight ColorColumn ctermbg=magenta guibg=IndianRed3
set colorcolumn=120
highlight cursor guifg=yellow guibg=red
highlight iCursor guifg=red guibg=white
highlight visual guifg=red guibg=yellow

" configure Language Server
:so $HOME/.config/nvim/config/lsp_config.vim
