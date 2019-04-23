source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"set diffexpr=MyDiff()
"function MyDiff()
"  let opt = '-a --binary '
"  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
"  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
"  let arg1 = v:fname_in
"  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
"  let arg2 = v:fname_new
"  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
"  let arg3 = v:fname_out
"  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
"  if $VIMRUNTIME =~ ' '
"    if &sh =~ '\<cmd'
"      if empty(&shellxquote)
"        let l:shxq_sav = ''
"        set shellxquote&
"      endif
"      let cmd = '"' . $VIMRUNTIME . '\diff"'
"    else
"      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
"    endif
"  else
"    let cmd = $VIMRUNTIME . '\diff'
"  endif
"  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
"  if exists('l:shxq_sav')
"    let &shellxquote=l:shxq_sav
"  endif
"endfunction

"--------------------插件管理--------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"colorscheme
Plugin 'morhetz/gruvbox'

" 状态条
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"buffer 状态
"Plugin 'bling/vim-bufferline'
"let g:bufferline_echo = 0
"let g:bufferline_active_buffer_left = '['
"let g:bufferline_active_buffer_right = ']'
"let g:bufferline_rotate = 1
"let g:bufferline_fixed_index =  0 "always first
"let g:bufferline_inactive_highlight = 'StatusLine'
"let g:bufferline_active_highlight = 'StatusLineNC'
"let g:bufferline_solo_highlight = 1
"let g:bufferline_pathshorten = 1

"markdown 语法
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'gabrielelana/vim-markdown'

"折叠代码
"Plugin 'tmhedberg/SimpylFold'
"自动缩进
"Plugin 'vim-scripts/indentpython.vim'
"语法自动完成
"Bundle 'Valloric/YouCompleteMe'
"语法检查和高亮
"Plugin 'vim-syntastic/syntastic'
"PEP 8 语法检测
"Plugin 'nvie/vim-flake8'

"LaTex 公式
"Plugin 'lervag/vimtex'
"let g:tex_flavor='latex'
"let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=0
"set conceallevel=1
"let g:tex_conceal='abdmg'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" 缩进线，目前和插入模式下的 ` 冲突
"Plugin 'Yggdroot/indentLine'

" 自动格式化
Plugin 'Chiel92/vim-autoformat'

" 括号、引号等自动配对
Plugin 'tpope/vim-surround'

" nerdtree
"Plugin 'scrooloose/nerdtree'

" 注释
Plugin 'scrooloose/nerdcommenter'

"tagbar
"Plugin 'majutsushi/tagbar'

"ctrlp
Plugin 'ctrlpvim/ctrlp.vim'

call vundle#end()            " required

filetype plugin indent on    " required

" Put your non-Plugin stuff after this line

"--------------------UltiSnips--------------

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/bundle/vim-snippets/UltiSnips', $HOME.'/UltiSnips']

"--------------------YouCompleteMe--------------

"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"--------------------vim-markdown--------------

"禁止自动折叠
let g:vim_markdown_folding_disabled = 1

"LaTeX 数学公式
"Used as `$x^2$`, `$$x^2$$`, escapable as `\$x\$` and `\$\$x\$\$`.
"let g:tex_conceal = ""
"let g:vim_markdown_math = 1

"高亮 JSON 语法，以 { 开始和 } 结束，需要 elzr/vim-json，已安装
"let g:vim_markdown_json_frontmatter = 1

"高亮 YAML Front Matter 语法，以 --- 开始和结束
"let g:vim_markdown_frontmatter = 1

"高亮 TOML Front Matter 语法，以 +++ 开始和结束
"let g:vim_markdown_toml_frontmatter = 1
"需要 https://github.com/cespare/vim-toml

"文件后缀和编程语言的对应，例如
"默认 `['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']`.
"let g:vim_markdown_fenced_languages = ['c=cpp', 'vim=vim', 'dos=dosini', 'asm=asm', 'bash=sh', 'javascript=javascript', 'php=php', 'sql=sql', 'mysql=mysql']

"--------------------tagbar--------------------

"快捷键
"nmap <F3> :TagbarToggle<CR>

"启动后自动focus
"let g:tagbar_autofocus = 1

"设定宽度，默认 40
"let g:tagbar_width = 26

"PHP类型设置
"let g:tagbar_type_php = {
"    \ 'kinds' : [
"        \ 'c:classes',
"        \ 'f:functions',
"    \ ]
"\ }

"让 tagbar 支持 markdown
"let g:tagbar_type_markdown = {
"    \ 'ctagstype': 'markdown',
"    \ 'ctagsbin' : '~/.vim/markdown2ctags.py',
"    \ 'ctagsargs' : '-f - --sort=yes',
"    \ 'kinds' : [
"        \ 's:sections',
"        \ 'i:images'
"    \ ],
"    \ 'sro' : '|',
"    \ 'kind2scope' : {
"        \ 's' : 'section',
"    \ },
"    \ 'sort': 0,
"\ }


"--------------------NerdTree--------------------

"map <C-n> :NERDTreeToggle<CR>

"--------------------打开上次的文件--------------------

"au VimLeave * mks! $HOME/Session.vim
"if expand("%")==""
"    if(expand("$HOME/Session.vim")==findfile(expand("$HOME/Session.vim")))
"         silent :source $HOME/Session.vim
"    endif
"endif

"--------------------colorscheme--------------------

"设置配色方案
"必须有这一行
"set t_Co=256
"否则单这一行出错
"colorscheme solarized
"let g:solarized_termcolors=256

set background=dark
colorscheme gruvbox

"--------------------airline--------------------
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline_powerline_fonts = 0
set laststatus=2

"禁用空白检测
silent! call airline#extensions#whitespace#disable()
let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
" indent: mixed indent within a line
" long:   overlong lines
" trailing: trailing whitespace
" mixed-indent-file: different indentation in different lines
" https://github.com/vim-airline/vim-airline/wiki/Screenshots

"--------------设置 = + - * 前后自动空格 , 号后面自动添加空格-------
if exists("g:equ")
    :inoremap = <c-r>=EqualSign('=')<CR>
    :inoremap + <c-r>=EqualSign('+')<CR>
    :inoremap - <c-r>=EqualSign('-')<CR>
    :inoremap * <c-r>=EqualSign('*')<CR>
    :inoremap / <c-r>=EqualSign('/')<CR>
    :inoremap > <c-r>=EqualSign('>')<CR>
    :inoremap < <c-r>=EqualSign('<')<CR>
    :inoremap , ,<space>
endif

function! EqualSign(char)
    if a:char  =~ '='  && getline('.') =~ ".*("
        return a:char
    endif
    let ex1 = getline('.')[col('.') - 3]
    let ex2 = getline('.')[col('.') - 2]

    if ex1 =~ "[-=+><>\/\*]"
        if ex2 !~ "\s"
            return "\<ESC>i".a:char."\<SPACE>"
        else
            return "\<ESC>xa".a:char."\<SPACE>"
        endif 
    else
        if ex2 !~ "\s"
            return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
        else
            return a:char."\<SPACE>\<ESC>a"
        endif 
    endif
endfunction

"----------------------------------------------------------------

"检测文件编码顺序
set fileencodings=utf-8,ucs-bom,chinese,cp936,gb18030,big5,euc-jp,euc-kr,latinl
"设置vim终端显示编码
set termencoding=utf-8
"设置vim内部编码
set encoding=utf-8
"设置写入文件时编码
set fileencoding=utf-8

"判定当前操作系统类型
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

"设置字体，字体中的空格要转义或用下划线代替，字体设置不当还曾导致全屏时下方和右
"方出现空白，无法真正全屏，如把下面的字号改为11则出现上述情况
if(g:iswindows==1)
    set guifont=等距更纱黑体_TC_LIGHT:h12
elseif has("unix")
    set guifont=Andale\ Mono\ 12
endif

"设置编码后重新加载菜单，否则菜单乱码
if(g:iswindows==1)
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "提示信息乱码
    language messages zh_CN.utf-8
endif

" GUI 设置
if has("gui_running")
    au GUIEnter * simalt ~x " 窗口启动时自动最大化
    set guioptions=''
endif

"没有字节序标记 Byte Order Mark 
set nobomb
"显示行号 number
set nu
" 启用相对行号 relativenumber
set rnu
"搜索不区分大小写
set ic

"高亮搜索
set hlsearch
"搜索输入文字时实时匹配
set incsearch

"设置softtab
set softtabstop=4
"tab设置为4个空格
set tabstop=4
"自动缩进为4个空格
set shiftwidth=4
"tab替换为空格
set expandtab

"不产生备份文件
set nobackup
"不产生撤销文件
set noundofile
"不产生swp临时文件
set noswapfile

"默认以双字节处理东亚字符
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
    set ambiwidth=double
endif

"高亮语法
"syntax enable
let python_highlight_all=1
syntax on

"禁止拼写检查
set nospell

"设置文件换行格式
set ff=unix
set ffs=unix,dos

"高亮光标所在行
set cursorline
highlight Cursor guifg=white guibg=black

"设置文本自动换行宽度 textwidth
set tw=80
"设置列宽提示 ColorColumn，+1 表示高亮 textwidth 后面的一列
set cc=+1
"改变 ColorColumn 默认颜色
"hi ColorColumn ctermbg=lightgrey guibg=lightgrey

"设置自动换行选项 formatoptions，具体含义 help formatoptions, help fo-table
set fo-=l
set fo+=t
set fo+=m
set fo+=M

"复制粘贴
nmap <C-Insert> ^v$h"*y
imap <C-Insert> <Esc>"*yyi

"visual模式下按 * 直接搜索选中的字符，
"但有个bug未处理，就是被搜索字符中不能包含 /
vmap * <C-Insert>/<S-Insert><CR>

"取消 ctrl + q 映射
nmap <C-q> <Nop>
nmap <C-Up> <Nop>
nmap <C-Down> <Nop>

"注释，还有多行注释问题
nmap cm/ I// <Esc>
nmap cm# I# <Esc>

"中英文空格
"command Spa s/\v(\s?\w+\s?)/ \1 /g

"Format Markdown
"command Fmd s/“/ `/g|s/”/` /g|s/（/(/g|s/）/)/g|s/,/，/g|s/./。/g|s/;/；/g|s/' / `/g|s/ '/` /g
"command Fmd s/' / `/g|s/ '/` /g|s/“/ `/g|s/”/` /g|s/（/(/g|s/）/)/g|s/,/，/g|s/./。/g|s/;/；/g

"Quote Uppercase
"command Quc s/\v (\u+)[ ,.]/ `\1` /g

"Write Markdown
"command Wmd w 文件名.md

"折叠代码中的 class、function 等代码块
set foldmethod=indent
set foldlevel=99

"更改折叠代码块默认的快捷键
nnoremap <space> za

" Virtualenv support
"py3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
"EOF

" 启用命令行自动补全增强模式
set wildmenu
set wildmode=longest:list,full

" 启用智能感知
set omnifunc=syntaxcomplete#Complete
" imap <silent> ` <C-X><C-O>

" NERDTree 快捷键
"nnoremap <C-N> :NERDTree<CR>

" 缓存快捷键
function! GetNChar()
     let l:number = 3
     let l:string = ""

     while l:number > 0
       let l:string .= nr2char(getchar())
       let l:number -= 1
     endwhile

     echo l:string
endfunction

" 未实现不用回车直接触发功能
"nnoremap gb :ls<CR>:buffer<Space>call GetNChar()<CR>
nnoremap gb :ls<CR>:buffer<Space>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

" CtrlP
"nmap <Leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMRU'
"let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_mruf_max = 250
let g:ctrlp_mruf_case_sensitive = 0
let g:ctrlp_working_path_mode = 'ra'
"  c - 当前文件所在的目录。
"  a - 当前文件所在的目录，除非这个目录为当前工作目录的子目录
"  r - 包含下列文件或者目录的最近的祖先目录:
"      .git .hg .svn .bzr _darcs
"  w - 用来修饰r：使用当前工作目录而不是当前文件所在目录进行查找
"  0 或者 <empty> - 禁用这项功能。
"
" 排除版本控制文件
if(g:iswindows==1)
    set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*,*\\.deploy_git\\*  " Windows ('noshellslash')
elseif has("unix")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.deploy_git/*        " Linux/MacOSX
endif
"启用会话缓存，按<F5>键可以清除当前目录的缓存以获取新文件，移除已删除的文件并应用新的忽略选项。
let g:ctrlp_use_caching = 1
"退出Vim时不删除缓存文件来启用跨会话的缓存
let g:ctrlp_clear_cache_on_exit = 0
"忽略的文件或目录
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](node_modules|scaffolds|themes|public|images)$',
\ 'file': '\v\.(exe|so|dll|json)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\ }

" autowrite
set autowrite

" undo 设置
set hidden

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000
