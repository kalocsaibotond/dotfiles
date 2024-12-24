" SOURCES:
" https://github.com/changemewtf/no_plugins
" https://github.com/YanivZalach/Vim_Config_NO_PLUGINS/tree/main

" Switching off Vi compatibility
set nocompatible

" Add numbers to the file.
set number relativenumber

" Set ruler
set colorcolumn=80

" Set shift width to 4 spaces.Set tab width to 4 columns.
set shiftwidth=4
set tabstop=4 

" Do wrap lines.
set wrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch
set hlsearch

" Show matching words during a search.
set showmatch

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Set the commands to save in history default number is 20.
set history=1000

" Enable type file detection. Vim will be able to try to detect the type of file is use.
filetype on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax enable

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Setting the character encoding of Vim to UTF-8
set encoding=UTF-8

" Smart tab
set smarttab

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer



" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags



" FILE BROWSING:

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

" Auto Completion - Enable Omni complete features
set omnifunc=syntaxcomplete#Complete

" Enable Spelling Suggestions for Auto-Completion:
set complete+=k
set completeopt=menu,menuone,noinsert

" Setting shell preference
if has('win32')
  if executable('powershell') " Getting rid of cmd if possible
    let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
    let &shellcmdflag = '-NoLogo -ExecutionPolicy RemoteSigned -Command '
    let &shellredir = '| Out-File -Encoding UTF8 %s'
    let &shellpipe  = '| Out-File -Encoding UTF8 %s'
    set shellquote= shellxquote=
  endif
endif
