" vimrc

" use wayland clipboard
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

" enable mouse support
set mouse=a
set ttymouse=xterm

" show line numbers
set number
highlight LineNr ctermfg=grey

" disable backup and swap files
set nobackup
set nowritebackup
set noswapfile

" set tab width to 2
set tabstop=2
set shiftwidth=0

" show whitespace characters
set listchars=tab:»\ ,eol:¬
set list

" autoreload files changed outside vim
set autoread

" enable syntax highlighting
syntax enable

" highlight 81st column
" set cc=81
" highlight ColorColumn ctermbg=lightgrey

" do not copy when pasting
xn p pgvy

set noshowmode
set noruler
set laststatus=0
set noshowcmd

" J and K to move up and down
nmap J }
nmap K {

" J and K to move up and down
vmap J }
vmap K {

function Q()
	if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		:q
	else
		:bw
	endif
endfunction

nn <C-f> /
nn <C-g> :Rg<CR>
nn <C-h> :bp<CR>
nn <C-l> :bn<CR>
nn <C-p> :Commands<CR>
nn <C-q> :q<CR>
nn <C-s> :w<CR>
nn <C-t> :Files<CR>
nn <C-w> :call Q()<CR>
nn U :redo<CR>
nn u :undo<CR>
