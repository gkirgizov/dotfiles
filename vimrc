" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim74/vimrc_example.vim or the vim manual
" and configure vim to your own liking!


"--------- Vim-Neovim compatability ---------
""is it needed?

"if !has('nvim')
"    set viminfo+=~/.vim/viminfo
"endif

"--------- Different settings ----------

    " Reload vim
    "nnoremap <M-r> :so ~/.vimrc

    set noswapfile
    " Keyboard layouts
    set keymap=russian-jcukenwin
    set iminsert=0
    set imsearch=-1

    " don't know really why
    set modifiable
    nnoremap ; :
    let mapleader=","
    " open help in vertical split on ':h'
    cabbrev h vert h

    " Hybrid line numbers
    set number relativenumber
    " Auto toggle between line number modes (credits to https://jeffkreeftmeijer.com/vim-number/)
    " TODO somehow disable toggling linenumbers for non-file buffers (e.g. nerdtree)
    augroup numbertoggle
      autocmd!
      autocmd WinEnter,BufEnter,FocusGained,InsertLeave * set relativenumber
      autocmd WinLeave,BufLeave,FocusLost,InsertEnter   * set norelativenumber
    augroup END

    set breakindent
    "set breakindentopt=shift:2
    "let &showbreak = '↳ '
    "set cpo+=n
    set scrolloff=10

    " Enable clipboard permanently
    set clipboard+=unnamedplus
    " Enable mouse
    set mouse=a
    " Allow switching from unsaved buffers
    set hidden
    " Easier buffer switching
    nnoremap gb :ls<CR>:b<Space>
    nnoremap <M-Tab> :bnext<CR>
    nnoremap <M-S-Tab> :bprev<CR>
    nnoremap <M-1> :buffer1<CR>
    nnoremap <M-2> :buffer2<CR>
    nnoremap <M-3> :buffer3<CR>
    nnoremap <M-4> :buffer4<CR>
    nnoremap <M-5> :buffer5<CR>
    nnoremap <M-6> :buffer6<CR>
    nnoremap <M-7> :buffer7<CR>
    nnoremap <M-8> :buffer8<CR>
    nnoremap <M-9> :buffer9<CR>

    " Indentation settings
    filetype plugin indent on
    syntax on
    " Show existing tab with 4 spaces width
    set tabstop=4
    " When indenting with '>', use 4 spaces width
    set shiftwidth=4
    " On pressing tab, insert 4 spaces
    set expandtab

    " Enable folding -- see plugins
    "set foldmethod=indent
    "set foldmethod=syntax
    "set foldlevel=10
    "set foldcolumn=4

    " Tell Vim which characters to show for expanded TABs,
    " trailing whitespace, and end-of-lines.
    "    if &listchars ==# 'eol:$'
    "        set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
    "    endif
    "    set list                " Show problematic characters.
    " Also highlight all tabs and trailing whitespace characters.
    "    highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
    "    match ExtraWhitespace /\s\+$\|\t/

    " Searching options
    set hlsearch
    set ignorecase
    set smartcase
    " Use <C-L> to clear the highlighting of :set hlsearch.
    if maparg('<C-L>', 'n') ==# ''
        nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
    endif

    " Set splitting"
    set splitbelow
    set splitright

    " Split navigations (through Alt key)
    nnoremap <M-j> <C-W><C-J>
    nnoremap <M-k> <C-W><C-K>
    nnoremap <M-l> <C-W><C-L>
    nnoremap <M-h> <C-W><C-H>

    " Allow closing bueffer without closing splits
    "nmap .d :b#<bar>bd#<CR>

    " Set automatic even resize of splits on every terminal window resize
    "   instead of manual { ctrl-w = } combination invocation
    autocmd VimResized * wincmd =

    " Hide everything on the last status line
    let s:hidden_all = 0
    function! ToggleHiddenAll()
        if s:hidden_all  == 0
            let s:hidden_all = 1
            set noshowmode
            set noruler
            set laststatus=0
            set noshowcmd
        else
            let s:hidden_all = 0
            set showmode
            set ruler
            set laststatus=2
            set showcmd
        endif
    endfunction
    nnoremap <S-h> :call ToggleHiddenAll()<CR>

"--------- Plugins section -------------

    " helper function for conditional plugin loading
    function! Cond(cond, ...)
      let opts = get(a:000, 0, {})
      return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
    endfunction

    call plug#begin('~/.vim/plugged')

        Plug 'nightsense/vimspectr'
        Plug 'morhetz/gruvbox'
        Plug 'frankier/neovim-colors-solarized-truecolor-only'
        Plug 'jonathanfilip/vim-lucius'
        "Plug 'flazz/vim-colorschemes'

        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
        Plug 'edkolev/tmuxline.vim'
        let g:airline#extensions#keymap#enabled = 0
        let g:airline_powerline_fonts=1
        let g:airline_theme='gruvbox'
        "let g:airline_left_sep = ''
        "let g:airline_right_sep = ''

        Plug 'bling/vim-bufferline'
        " scrolling with fixed current buffer position
        let g:bufferline_rotate = 1
        " scrolling without fixed current buffer position
        "let g:bufferline_rotate = 2
        let g:bufferline_fixed_index = 0
        let g:bufferline_pathshorten = 1

        "set autowriteall
        Plug '907th/vim-auto-save'
        let g:auto_save = 0 " enable AutoSave on Vim startup
        let g:auto_save_event = ["InsertLeave"]

        " Grammar and language use checkers
        set spelllang=en_us,ru
        "Plug 'reedes/vim-wordy'
        "noremap <silent> <F8> : <C-u>NextWordy<CR>
        " Plug 'rhysd/vim-grammarous'
        " let g:grammarous#languagetool_cmd = 'languagetool'
        " " jump immediately after check to the first error
        " let g:grammarous#show_first_error = 0
        " nmap <buffer><leader>o <Plug>(grammarous-open-info-window)
        " " nmap <buffer><leader>c <Plug>(grammarous-close-info-window)
        " nmap <buffer><leader>n <Plug>(grammarous-move-to-next-error)
        " nmap <buffer><leader>p <Plug>(grammarous-move-to-previous-error)


        "Plug 'vim-scripts/AutoClose'

        Plug 'ntpeters/vim-better-whitespace'
        map <F5> : StripWhitespace<CR>

        Plug 'easymotion/vim-easymotion'
        map <Leader>m <Plug>(easymotion-prefix)
        Plug 'ctrlpvim/ctrlp.vim'
        nnoremap <Leader>tp :CtrlPTag<CR>
        Plug 'majutsushi/tagbar'
        nnoremap <silent> <Leader>tb :TagbarToggle<CR>
        " TODO some key for regenerate TAGS file?
        Plug 'mbbill/undotree'
        map <C-u> : UndotreeToggle<CR>
        Plug 'scrooloose/nerdtree'
        map <C-n> : NERDTreeToggle<CR>

        Plug 'scrooloose/nerdcommenter'
        " Add spaces after comment delimiters by default
        let g:NERDSpaceDelims = 1
        " Use compact syntax for prettified multi-line comments
        let g:NERDCompactSexyComs = 1
        " Align line-wise comment delimiters flush left instead of following code indentation
        let g:NERDDefaultAlign = 'left'
        " Allow commenting and inverting empty lines (useful when commenting a region)
        let g:NERDCommentEmptyLines = 1
        " Enable trimming of trailing whitespace when uncommenting
        let g:NERDTrimTrailingWhitespace = 1
        Plug 'pseewald/vim-anyfold'
        autocmd BufReadPre,FileReadPre * AnyFoldActivate
        set foldlevel=10

        " Syntaxes
        Plug 'sheerun/vim-polyglot'
        "Plug 'tikhomirov/vim-glsl'
        let g:scala_scaladoc_indent=1

        " Auto-complete
        Plug 'Shougo/deoplete.nvim', Cond(has('nvim'))
        let g:deoplete#enable_at_startup=1
        let g:deoplete#sources = {}
        let g:deoplete#sources._ = ['buffer', 'file', 'ultisnips']
        Plug 'zchee/deoplete-jedi', Cond(has('nvim'))
        let g:deoplete#sources.python = ['buffer', 'file', 'jedi']
        Plug 'zchee/deoplete-clang', Cond(has('nvim'))
        let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
        let g:deoplete#sources#clang#clang_header='/usr/lib/clang'
        Plug 'SirVer/ultisnips'
        let g:UltiSnipsExpandTrigger="<M-i>"
        let g:UltiSnipsJumpForwardTrigger="<c-b>"
        let g:UltiSnipsJumpBackwardTrigger="<c-z>"
        Plug 'honza/vim-snippets'
        Plug 'ervandew/supertab'
        let g:SuperTabDefaultCompletionType = "<c-n>"

        Plug 'benekastah/neomake', Cond(has('nvim'))

    call plug#end()

    " Neomake settings ('call' must come after 'call plug#end()'
    if has('nvim')
        "call neomake#configure#automake('w')
        let g:neomake_open_list = 2
        let g:neomake_cpp_enabled_makers = ['clang']
    endif


"--------- Additional settings section -------------


    " Colors
    "
    " some theme-specific options
    let g:solarized_contrast = "high"
    " let g:solarized_visibility = "low"
    " let g:solarized_termtrans = 1
    let g:gruvbox_italic = 1
    "
    " need this for transparent background
    if has('nvim')
        au ColorScheme * hi Normal ctermbg=none guibg=none
        au ColorScheme * hi NonText ctermbg=none guibg=none
    endif
    set termguicolors
    set background=dark
    colorscheme gruvbox

