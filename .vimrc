syntax enable

" Enable filetype plugins
filetype plugin on
filetype indent on

set scrolloff=3 "Number of lines above/below cursor
set path+=**    "Search down into subfolders (provides tab-completion)
set wildmenu    "Display all matching files when we tab complete
set wildmode=list:longest,full
set number
set relativenumber
set ruler       "Always show current position
set splitbelow
set splitright
" Moving easier between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Resizing
noremap <Up> :resize +2<CR>
noremap <Down> :resize -2<CR>
noremap <Left> :vertical resize +2<CR>
noremap <Right> :vertical resize -2<CR>
set ignorecase  "Ignore case when searching
set smartcase   "It's case sensitive if the pattern has an uppercase letter
set hlsearch    "Highlight search results
set incsearch   "Incremental search
set magic       "Regular expression
" Unset last highligh search pattern by hitting ENTER
nnoremap <CR> :nohlsearch<CR>
set nobackup
set expandtab   "Use spaces instead of tab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set termguicolors
"set cmdheight=2 "Give more space for displaying messages
set hidden

"    PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
call plug#end()

"    COLORS
"colorscheme desert

let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_contrast_dark = 'soft'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'
colorscheme gruvbox
set background=dark

set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=black
set cursorline
set cursorcolumn
highlight CursorLine ctermbg=Yellow cterm=bold guibg=#2b2b2b
highlight CursorColumn ctermbg=Yellow cterm=bold guibg=#2b2b2b

" Show trailing whitespaces and spaces before a tab (needs to be set after colorscheme)
:highlight ExtraWhitespace ctermbg=DarkYellow guibg=DarkYellow
:match ExtraWhitespace /\s\+$\| \+ze\t/

"    OTHER MAPPING AND SHORTCUTS
" Spell-check set to F7
"   To download Vero and to create pt dictionary:
"   https://www.vivaolinux.com.br/artigo/Corretor-Ortografico-no-Vim-Guia-definitivo
map <F7> :setlocal spell! spelllang=pt,en<CR>
" Apply macros with Q
nnoremap Q @q
vnoremap :norm @q<CR>

"nnoremap S :%s///gcI<Left><Left><Left><Left><Left>

"    SConstruct
au BufRead,BufNewFile SConstruct set filetype=python

"   c, LATEX and .bib
" Navigation with guides
autocmd FileType c,tex,bib inoremap <A-\> <Esc>/<++><CR>"_c4l
autocmd FileType c,tex,bib vnoremap <A-\> <Esc>/<++><CR>"_c4l
autocmd FileType c,tex,bib map <A-\> <Esc>/<++><CR>"_c4l

"   c
autocmd FileType c inoremap 'pr printf("");<CR><++><Esc>kf"a
autocmd FileType c inoremap 'for for<Space>()<Space>{<CR>}<Esc>kf)i
autocmd FileType c inoremap 'if if<Space>()<Space>{<CR><++><CR>}<CR><++><Esc>3kf)i
autocmd FileType c inoremap 'eif else<Space>if<Space>()<Space>{<CR><++><CR>}<CR><++>
                                 \<Esc>3kf)i
autocmd FileType c inoremap 'el  else<Space>{<CR>}<CR><++><Esc>kO

"   LATEX and .bib

" Managing long lines (
"   It might be necessary to format older files with gq (ex.: gqip or gqG)
"   see https://agilesysadmin.net/how-to-manage-long-lines-in-vim/
autocmd FileType tex,bib set linebreak
autocmd FileType tex,bib let &showbreak="\u2026"
autocmd FileType tex,bib set textwidth=85
autocmd FileType tex,bib set colorcolumn=+1
"autocmd FileType tex,bib set formatoptions+=a

" Compiling Latex files
" Yank filename into registers
autocmd FileType tex map <Leader>n :let @k=expand("%:p")<CR>
                                    \ :let @l=expand("%:r")<CR><CR>
" View pdf file
autocmd FileType tex map <Leader>v :!zathura <C-R>l.pdf&<CR><CR>
" Compile file without bibtex
autocmd FileType tex map <Leader>c :w<CR> :!pdflatex <C-R>k<CR><CR>
" Compile file with bibtex
autocmd FileType tex map <Leader>b :w<CR> :!pdflatex <C-R>k<CR> :!bibtex <C-R>l<CR>
                                   \ :!pdflatex <C-R>l<CR> :!pdflatex <C-R>l<CR><CR>

" Code snippets
autocmd FileType tex inoremap 'frame \begin{frame}<CR>\frametitle{}<CR><++><CR>
                                  \\end{frame}<CR><CR><++><Esc>4kf}i
autocmd FileType tex inoremap 'tbf \textbf{}<Esc>T{i
autocmd FileType tex inoremap 'tit \textit{}<Esc>T{i
autocmd FileType tex inoremap 'mbf \mathbf{}<Esc>T{i
autocmd FileType tex inoremap 'mcal \mathcal{}<Esc>T{i
autocmd FileType tex inoremap 'bs \boldsymbol{}<Esc>T{i
autocmd FileType tex inoremap 'fr \frac{}{}<Esc>2T{i
autocmd FileType tex inoremap 'p \partial
autocmd FileType tex inoremap 'cbox \colorbox{}{}<Esc>2T{i
autocmd FileType tex inoremap 'vs \vspace{}<CR><++><Esc>kf}i
autocmd FileType tex inoremap 'ct \cite{}<Esc>T{i
autocmd FileType tex inoremap 'ctp \citep{}<Esc>T{i
autocmd FileType tex inoremap 'ctt \citet{}<Esc>T{i
autocmd FileType tex inoremap 'fig \begin{figure}[t]<CR>\centering<CR>
                                  \\includegraphics[width=3cm]{}<CR>\end{figure}<CR><CR>
                                  \<++><Esc>3kf}i
autocmd FileType tex inoremap 'item \begin{itemize}<CR><CR>\end{itemize}<CR><CR><++>
                                   \<Esc>3kA\item<Space>
autocmd FileType tex inoremap 'li \item<Space>
autocmd FileType tex inoremap 'enum \begin{enumerate}<CR><CR>\end{enumerate}<CR><CR>
                                   \<++><Esc>3kA\item<Space>
autocmd FileType tex inoremap 'tab \begin{tabular}<CR><++><CR>\end{tabular}<CR><CR>
                                  \<++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap 'eq \begin{equation}<CR>\end{equation}<CR><++><Esc>kO
autocmd FileType tex inoremap 'al \begin{align}<CR>\end{align}<CR><++><Esc>kO
autocmd FileType tex inoremap 'la \label{}<Esc>T{i
autocmd FileType tex inoremap 'ref \ref{}<Esc>T{i
autocmd FileType tex inoremap 'Ref (\ref{})<Esc>T{i
autocmd FileType tex inoremap 'pmat \begin{pmatrix}<CR>\end{pmatrix}<CR><++><Esc>kO
autocmd FileType tex inoremap 'bmat \begin{bmatrix}<CR>\end{bmatrix}<CR><++><Esc>kO
autocmd FileType tex inoremap 'ch \chapter{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap 'sec \section{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap 'ssec \subsection{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap 'sssec \subsubsection{}<CR><CR><++><Esc>2kf}i
autocmd FileType tex inoremap 'col \begin{columns}[T]<CR>\begin{column}{.5\textwidth}<CR>
                                  \\end{column}<CR>\begin{column}{.5\textwidth}
                                  \<CR><++><CR>\end{column}<CR>\end{columns}<CR><CR>
                                  \<++><Esc>6kO


autocmd FileType bib inoremap 'a @article{,<CR>
                                         \author<Space>=<Space>{<++>},<CR>
                                         \title<Space>=<Space>{<++>},<CR>
                                         \journal<Space>=<Space>{<++>},<CR>
                                         \volume<Space>=<Space>{<++>},<CR>
                                         \number<Space>=<Space>{<++>},<CR>
                                         \pages<Space>=<Space>{<++>},<CR>
                                         \year<Space>=<Space>{<++>},<CR>
                                         \doi<Space>=<Space>{<++>},<CR>
                                         \url<Space>=<Space>{<++>},<CR>
                                         \}<CR><++><Esc>11kf,<Esc>i
autocmd FileType bib inoremap 'b @book{,<CR>
                                      \author<Space>=<Space>{<++>},<CR>
                                      \title<Space>=<Space>{<++>},<CR>
                                      \publisher<Space>=<Space>{<++>},<CR>
                                      \series<Space>=<Space>{<++>},<CR>
                                      \volume<Space>=<Space>{<++>},<CR>
                                      \year<Space>=<Space>{<++>},<CR>
                                      \address<Space>=<Space>{<++>},<CR>
                                      \note<Space>=<Space>{<++>},<CR>
                                      \doi<Space>=<Space>{<++>},<CR>
                                      \url<Space>=<Space>{<++>},<CR>
                                      \}<CR><++><Esc>12kf,<Esc>i
autocmd FileType bib inoremap 'c @incollection{,<CR>
                                              \author<Space>=<Space>{<++>},<CR>
                                              \title<Space>=<Space>{<++>},<CR>
                                              \booktitle<Space>=<Space>{<++>},<CR>
                                              \publisher<Space>=<Space>{<++>},<CR>
                                              \volume<Space>=<Space>{<++>},<CR>
                                              \chapter<Space>=<Space>{<++>},<CR>
                                              \pages<Space>=<Space>{<++>},<CR>
                                              \year<Space>=<Space>{<++>},<CR>
                                              \address<Space>=<Space>{<++>},<CR>
                                              \doi<Space>=<Space>{<++>},<CR>
                                              \url<Space>=<Space>{<++>},<CR>
                                              \}<CR><++><Esc>13kf,<Esc>i
autocmd FileType bib inoremap 'i @inproceedings{,<CR>
                                               \author<Space>=<Space>{<++>},<CR>
                                               \title<Space>=<Space>{<++>},<CR>
                                               \publisher<Space>=<Space>{<++>},<CR>
                                               \booktitle<Space>=<Space>{<++>},<CR>
                                               \pages<Space>=<Space>{<++>},<CR>
                                               \year<Space>=<Space>{<++>},<CR>
                                               \doi<Space>=<Space>{<++>},<CR>
                                               \url<Space>=<Space>{<++>},<CR>
                                               \}<CR><++><Esc>10kf,<Esc>i
autocmd FileType bib inoremap 'm @mastersthesis{,<CR>
                                               \author<Space>=<Space>{<++>},<CR>
                                               \title<Space>=<Space>{<++>},<CR>
                                               \school<Space>=<Space>{<++>},<CR>
                                               \year<Space>=<Space>{<++>},<CR>
                                               \address<Space>=<Space>{<++>},<CR>
                                               \}<CR><++><Esc>7kf,<Esc>i

" Code snippets to thesis
autocmd FileType tex inoremap 'bfx \mathbf{x}
autocmd FileType tex inoremap 'bfu \mathbf{u}
autocmd FileType tex inoremap 'bfU \mathbf{U}
autocmd FileType tex inoremap 'bfe \mathbf{e}
autocmd FileType tex inoremap 'bfp \mathbf{p}
autocmd FileType tex inoremap 'bfn \mathbf{n}
autocmd FileType tex inoremap 'bfn1 \boldsymbol{\nu_1}
autocmd FileType tex inoremap 'bfn2 \boldsymbol{\nu_2}
autocmd FileType tex inoremap 'bfn3 \boldsymbol{\nu_3}
autocmd FileType tex inoremap 'bfV \mathbf{V}
autocmd FileType tex inoremap 'bf0 \mathbf{0}
autocmd FileType tex inoremap 'bfy \mathbf{y}
autocmd FileType tex inoremap 'bfB \mathbf{B}
autocmd FileType tex inoremap 'bfP \mathbf{P}
autocmd FileType tex inoremap 'bfI \mathbf{I}
autocmd FileType tex inoremap 'bx \overline{\mathbf{x}}
autocmd FileType tex inoremap 'bp \overline{\mathbf{p}}
autocmd FileType tex inoremap 'bT \overline{\mathbf{T}}
autocmd FileType tex inoremap 'bfG \boldsymbol{\Gamma}
autocmd FileType tex inoremap 'H \mathcal{H}
autocmd FileType tex inoremap 'Gik \Gamma_{ik}
autocmd FileType tex inoremap 'G11 \Gamma_{11}
autocmd FileType tex inoremap 'G22 \Gamma_{22}
autocmd FileType tex inoremap 'G33 \Gamma_{33}
autocmd FileType tex inoremap 'G12 \Gamma_{12}
autocmd FileType tex inoremap 'G13 \Gamma_{13}
autocmd FileType tex inoremap 'G23 \Gamma_{23}
autocmd FileType tex inoremap 'a11 A_{11}
autocmd FileType tex inoremap 'a22 A_{22}
autocmd FileType tex inoremap 'a33 A_{33}
autocmd FileType tex inoremap 'a44 A_{44}
autocmd FileType tex inoremap 'a55 A_{55}
autocmd FileType tex inoremap 'a66 A_{66}
autocmd FileType tex inoremap 'a12 A_{12}
autocmd FileType tex inoremap 'a13 A_{13}
autocmd FileType tex inoremap 'a23 A_{23}
autocmd FileType tex inoremap 'e1 \epsilon^{(1)}
autocmd FileType tex inoremap 'e2 \epsilon^{(2)}
autocmd FileType tex inoremap 'd1 \delta^{(1)}
autocmd FileType tex inoremap 'd2 \delta^{(2)}
autocmd FileType tex inoremap 'd3 \delta^{(3)}
autocmd FileType tex inoremap 'g1 \gamma^{(1)}
autocmd FileType tex inoremap 'g2 \gamma^{(2)}
autocmd FileType tex inoremap 'L11 \Lambda_{11}
autocmd FileType tex inoremap 'L22 \Lambda_{22}
autocmd FileType tex inoremap 'L33 \Lambda_{33}
autocmd FileType tex inoremap 'L12 \Lambda_{12}
autocmd FileType tex inoremap 'L13 \Lambda_{13}
autocmd FileType tex inoremap 'L23 \Lambda_{23}
autocmd FileType tex inoremap 'L123 \Lambda_{123}
autocmd FileType tex inoremap 'Ce1 C_{\epsilon^{(1)}}
autocmd FileType tex inoremap 'Ce2 C_{\epsilon^{(2)}}
autocmd FileType tex inoremap 'Cd1 C_{\delta^{(1)}}
autocmd FileType tex inoremap 'Cd2 C_{\delta^{(2)}}
autocmd FileType tex inoremap 'Cd3 C_{\delta^{(3)}}

