

set backspace=eol,start,indent
syntax on
filetype on
filetype plugin indent on
set title
set mouse=a
set autoindent
set number
set nobackup
set wildmenu
set wildmode=list:longest
set showmatch
set modeline
set modelines=5
set hidden
set confirm
set equalalways
set paste
set noshowmode
" }}}
" GUI or no GUI, that's the question {{{
  if has('gui_running')
    set guicursor+=a:blinkon0       " Cursor doesn't blink - it's annoying
    set guioptions-=m               " No Menubar
    set guioptions-=T               " No Toolbar
    set guioptions-=l               " No Scrollbar left
    set guioptions-=L               " No Scrollbar left when split
    set guioptions-=r               " No Scrollbar right
    set guioptions-=r               " No Scrollbar right when split

    set laststatus=2                " always show statusline

    set lines=40                    " Height
    set columns=85                  " Width

	set gfn=Monaco\ 8
  endif
" }}}
" Status line {{{
  set laststatus=2      " always show statusline

  " Generic Statusline {{{
  function! SetStatus()
    setl statusline+=
          \%1*\ %f
          \%H%M%R%W%7*\ ┃
          \%2*\ %Y\ <<<\ %{&ff}%7*\ ┃
  endfunction

  function! SetRightStatus()
    setl statusline+=
          \%5*\ %{StatusFileencoding()}%7*\ ┃
          \%5*\ %{StatusBuffersize()}%7*\ ┃
          \%=%<%7*\ ┃
          \%5*\ %{StatusWrapON()}
          \%6*%{StatusWrapOFF()}\ %7*┃
          \%5*\ %{StatusInvisiblesON()}
          \%6*%{StatusInvisiblesOFF()}\ %7*┃
          \%5*\ %{StatusExpandtabON()}
          \%6*%{StatusExpandtabOFF()}\ %7*┃
          \%5*\ w%{StatusTabstop()}\ %7*┃
          \%3*\ %l,%c\ >>>\ %P
          \\
  endfunction " }}}

  " Update when leaving Buffer {{{
  function! SetStatusLeaveBuffer()
    setl statusline=""
    call SetStatus()
  endfunction
  au BufLeave * call SetStatusLeaveBuffer() " }}}

  " Update when switching mode {{{
  function! SetStatusInsertMode(mode)
    setl statusline=%4*
    if a:mode == 'i'
      setl statusline+=\ Editing\ ◥
    elseif a:mode == 'r'
      setl statusline+=\ Replacing\ ◥
    elseif a:mode == 'normal'
      setl statusline+=\ \ ◥
    endif
    call SetStatus()
    call SetRightStatus()
  endfunction

  au VimEnter     * call SetStatusInsertMode('normal')
  au InsertEnter  * call SetStatusInsertMode(v:insertmode)
  au InsertLeave  * call SetStatusInsertMode('normal')
  au BufEnter     * call SetStatusInsertMode('normal') " }}}

  " Some Functions shamelessly ripped and modified from Cream
  "fileencoding (three characters only) {{{
  function! StatusFileencoding()
    if &fileencoding == ""
      if &encoding != ""
        return &encoding
      else
        return " -- "
      endif
    else
      return &fileencoding
    endif
  endfunc " }}}
  " &expandtab {{{
  function! StatusExpandtabON()
    if &expandtab == 0
      return "tabs"
    else
      return ""
    endif
  endfunction "
  function! StatusExpandtabOFF()
    if &expandtab == 0
      return ""
    else
      return "tabs"
    endif
  endfunction " }}}
  " tabstop and softtabstop {{{
  function! StatusTabstop()

    " show by Vim option, not Cream global (modelines)
    let str = "" . &tabstop
    " show softtabstop or shiftwidth if not equal tabstop
    if   (&softtabstop && (&softtabstop != &tabstop))
    \ || (&shiftwidth  && (&shiftwidth  != &tabstop))
      if &softtabstop
        let str = str . ":sts" . &softtabstop
      endif
      if &shiftwidth != &tabstop
        let str = str . ":sw" . &shiftwidth
      endif
    endif
    return str

  endfunction " }}}
  " Buffer Size {{{
  function! StatusBuffersize()
    let bufsize = line2byte(line("$") + 1) - 1
    " prevent negative numbers (non-existant buffers)
    if bufsize < 0
      let bufsize = 0
    endif
    " add commas
    let remain = bufsize
    let bufsize = ""
    while strlen(remain) > 3
      let bufsize = "," . strpart(remain, strlen(remain) - 3) . bufsize
      let remain = strpart(remain, 0, strlen(remain) - 3)
    endwhile
    let bufsize = remain . bufsize
    " too bad we can't use "¿" (nr2char(1068)) :)
    let char = "b"
    return bufsize . char
  endfunction " }}}
  " Show Invisibles {{{
  function! StatusInvisiblesON()
    "if exists("g:LIST") && g:LIST == 1
    if &list
      if     &encoding == "latin1"
        return "¶"
      elseif &encoding == "utf-8"
        return "¶"
      else
        return "$"
      endif
    else
      return ""
    endif
  endfunction
  function! StatusInvisiblesOFF()
    "if exists("g:LIST") && g:LIST == 1
    if &list
      return ""
    else
      if     &encoding == "latin1"
        return "¶"
      elseif &encoding == "utf-8"
        return "¶"
      else
        return "$"
      endif
    endif
  endfunction " }}}
  " Wrap Enabled {{{
  function! StatusWrapON()
    if &wrap
      return "wrap"
    else
      return ""
    endif
  endfunction
  function! StatusWrapOFF()
    if &wrap
      return ""
    else
      return "wrap"
    endif
  endfunction
  " }}}
" }}}
" Tabstops {{{
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set autoindent
  set smartindent
  set expandtab
" }}}
" Invisibles {{{
  set listchars=tab:>\ ,eol:<
  set list
  nmap <silent> <F5> :set list!<CR>
" }}}
" Tabstops {{{
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set autoindent
  set smartindent
  set expandtab
" }}}
" Invisibles {{{
  set listchars=tab:>\ ,eol:<
  set list
  nmap <silent> <F5> :set list!<CR>
" }}}
" Folds {{{
  set foldmethod=marker
  set foldcolumn=1
  " au BufWinLeave * mkview
  " au BufWinEnter * silent loadview
" }}}
" Pairings {{{
  set showmatch
" }}}
" Margins {{{
  set scrolloff=5
  set sidescroll=5
" }}}
" Search {{{
  set incsearch
  set ignorecase

  " Toggle that stupid highlight search
  nmap <silent> ,n :set invhls<CR>:set hls?<CR>
" }}}
" Backup files {{{
  set nobackup
  set nowb
  set noswapfile
" }}}
" Completion {{{
  set wildmenu
  set wildmode=longest,full,list

  set ofu=syntaxcomplete#Complete
" }}}
" Snipmate {{{
  imap <tab> <C-r>=TriggerSnippet()<CR>
" }}}
" NERDTree {{{
  map <F3> :NERDTreeToggle<CR>

  let NERDTreeChDirMode = 2
  let NERDTreeShowBookmarks = 1
" }}}
" Wrapping {{{
  set linebreak
  set showbreak=↳\
" toggle wrapping
  nmap <silent> <F12> :let &wrap = !&wrap<CR>
" }}}
" RagTag {{{
  imap <M-O> <Esc>o
  imap <C-J> <Down>
  let g:ragtag_global_maps = 1

  imap <C-Space> <C-X><Space>
  imap <C-CR> <C-X><CR>
" }}}
" 'Bubbling' {{{
  nmap <C-up> [e
  nmap <C-down> ]e
  vmap <C-up> [egv
  vmap <C-down> ]egv
" }}}
" Formatting with Par (gqip) {{{
  set formatprg=par\ -req
  nmap <F9> gqip
" }}}
" Pasting {{{
  set paste
  nnoremap p ]p
  nnoremap <c-p> p
" }}}
" Macros {{{
  " Execute macro "q" with space
  nmap <Space> @q
  " Map @ to + for more comfortable macros on DE kb layout
  nmap + @
" }}}
