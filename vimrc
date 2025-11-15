" Minimal vimrc for backward compatibility
" For full configuration, use Neovim: ~/.config/nvim/init.lua

" Basic settings
set nocompatible
filetype plugin indent on
syntax enable

" Indentation
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" UI
set number
set relativenumber
set cursorline
set colorcolumn=80

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Colorscheme
try
  colorscheme twilight256
catch
  colorscheme default
endtry

" If Neovim is available, prefer it
if executable('nvim')
  command! -nargs=* -complete=file -bar Edit nvim <args>
endif
