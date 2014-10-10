set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
"Bundle 'lsdr/monokai'
"Bundle 'jaromero/vim-monokai-refined'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set noet ci pi sts=0 sw=4 ts=4 nu
syntax enable
colorscheme twilight256
