" Disable Netrw
let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" Disable SWAP files
set updatecount=0

call plug#begin()
  Plug 'nvim-tree/nvim-web-devicons' " OPTIONAL: for file icons
  Plug 'romgrk/barbar.nvim'
  Plug 'airblade/vim-rooter'

  " Neotree
  Plug 'nvim-neo-tree/neo-tree.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'MunifTanjim/nui.nvim'
  Plug 's1n7ax/nvim-window-picker'

  " Stuff for Elixir LSP
  Plug 'neovim/nvim-lspconfig'

  " Autocompletion acording to https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
  Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin
  Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp
  Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp
  Plug 'L3MON4D3/LuaSnip' " Snippets plugin

  Plug 'onsails/lspkind-nvim'
  Plug 'ryanoasis/vim-devicons'

  " Git integration
  Plug 'tpope/vim-fugitive'
  Plug 'lewis6991/gitsigns.nvim'

  " Telescope
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
  Plug 'BurntSushi/ripgrep'
  Plug 'sharkdp/fd' " (finder)
  Plug 'nvim-treesitter/nvim-treesitter' " (finder/preview)
  Plug 'nvim-tree/nvim-web-devicons' " (icons)

  " colorschemes
  Plug 'folke/tokyonight.nvim'
  Plug 'catppuccin/nvim'
call plug#end()
PlugInstall | quit

colorscheme catppuccin-mocha

" " normal mode
" nmap <C-l> :bn <CR>
" nmap <C-h> :bp <CR>
" nmap <C-m> :bd <CR>

nmap <C-j> 5j
vmap <C-j> 5j
nmap <C-k> 5k
vmap <C-k> 5k

map <D-a> ggVG<CR>

" barbar mappings
nnoremap <silent>    <C-l> <Cmd>BufferNext<CR>
nnoremap <silent>    <C-h> <Cmd>BufferPrevious<CR>
nnoremap <silent>    <C-m> <Cmd>BufferClose<CR>

" command mode
cnoremap <C-a> <Home>
cnoremap <C-d> <Delete>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" CMD-v for paste in normal mode
nnoremap <D-v> p
" CMD-v for paste in visual mode
vnoremap <D-v> p
" CMD-v for paste in command mode (works with system clipboard)
cnoremap <D-v> <C-r>+
" CMD-v for paste in insert mode (works with system clipboard)
inoremap <D-v> <C-r>+
" CMD-c for copy in select mode
snoremap <D-c> "+y
vnoremap <D-c> "+y
" CMD-c for cut in select mode
snoremap <D-x> "+d
vnoremap <D-x> "+d

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

" Neotree and NERDTree
:so $HOME/.config/nvim/config/tree_config.vim
nmap <Esc><Esc> :Neotree reveal <CR>

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

" configure Telescope shortcuts
:so $HOME/.config/nvim/config/telescope_config.vim
nnoremap <D-t> <cmd>Telescope find_files<cr>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <D-g> <cmd>Telescope live_grep<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Disable CMD-q (doesn't appear to work, need to disable CMD-q in system
" keyboard shortcuts)
let g:neovide_confirm_quit = v:true
noremap <D-q> <nop>

" Configure vim-rooter to only look at the Git directory (fixes the issue with
" umbrella apps)
let g:rooter_patterns = ['.git']

" configure GitSigns
:so $HOME/.config/nvim/config/git_config.vim
