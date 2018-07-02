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
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
set rtp+=$VIM/vimfiles/bundle/Vundle.vim/
call vundle#begin('$VIM/vimfiles/bundle/')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"-------------
" plugin on GitHub repo

"colorscheme
Plugin 'morhetz/gruvbox'

"状态条
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

"markdown 语法
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'gabrielelana/vim-markdown'

"tagbar
"Plugin 'majutsushi/tagbar'

"nerdtree
"Plugin 'scrooloose/nerdtree'

"ctrlp
"Plugin 'ctrlpvim/ctrlp.vim'

"JSON 语法
"Plugin 'elzr/vim-json'

"Plugin 'suan/vim-instant-markdown'

"Plugin 'iamcco/mathjax-support-for-mkdp'
"Plugin 'iamcco/markdown-preview.vim'

"-------------
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

"-------------
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'


"-------------
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"-------------
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line

call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"--------------------vim-airline--------------

"禁用空白检测
silent! call airline#extensions#whitespace#disable()
let g:airline#extensions#whitespace#enabled = 0
"let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing', 'long', 'mixed-indent-file' ]
" indent: mixed indent within a line
" long:   overlong lines
" trailing: trailing whitespace
" mixed-indent-file: different indentation in different lines

"--------------------vim-markdown--------------

"禁止语法隐藏，改为 0 则
"set conceallevel=2

"禁止自动折叠
let g:vim_markdown_folding_disabled = 1

"LaTeX 数学公式
"Used as `$x^2$`, `$$x^2$$`, escapable as `\$x\$` and `\$\$x\$\$`.
let g:tex_conceal = ""
let g:vim_markdown_math = 1

"高亮 JSON 语法，以 { 开始和 } 结束，需要 elzr/vim-json，已安装
let g:vim_markdown_json_frontmatter = 1

"高亮 YAML Front Matter 语法，以 --- 开始和结束
let g:vim_markdown_frontmatter = 1

"高亮 TOML Front Matter 语法，以 +++ 开始和结束
"let g:vim_markdown_toml_frontmatter = 1
"需要 https://github.com/cespare/vim-toml

"文件后缀和编程语言的对应，例如
"```asm  表示代码块使用 $VIM/syntax 目录下的语法文件 asm.vim
"...
"```
"默认 `['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']`.
let g:vim_markdown_fenced_languages = ['c=cpp', 'vim=vim', 'dos=dosini', 'asm=asm', 'bash=sh', 'javascript=javascript', 'php=php', 'sql=sql', 'mysql=mysql']

"--------------------instant-markdown--------------

"自动打开预览窗口
"let g:instant_markdown_autostart = 0

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

"set background=light
colorscheme gruvbox

"--------------------设置 = + - * 前后自动空格 , 号后面自动添加空格--------------------
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

"-----------------------------------------------------------------------------

"检测文件编码顺序
set fileencodings=ucs-bom,utf-8,chinese,cp936,gb18030,big5,euc-jp,euc-kr,latinl
"设置vim终端显示编码
set termencoding=utf8
"设置vim内部编码
set encoding=utf8
"设置写入文件时编码
set fileencoding=utf8

"判定当前操作系统类型
if(has("win32") || has("win95") || has("win64") || has("win16"))
    let g:iswindows=1
else
    let g:iswindows=0
endif

"设置字体，字体中的空格要转义
if(g:iswindows==1)
    set guifont=DejaVu\ Sans\ Mono:h12:w6
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
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    "set showtabline=0 " 隐藏Tab栏
endif

"没有字节序标记 Byte Order Mark 
set nobomb
"显示行号
set number
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
syntax enable

"禁止拼写检查
set nospell

"设置文件换行格式
set ff=unix
set ffs=unix,dos

"高亮光标所在行
set cursorline

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

"插入模式进入普通模式自动切换为英文输入法
let g:input_toggle = 1

function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

"普通模式进入插入模式自动切换为中文输入法
function! Fcitx2zh()
   let s:input_status = system("fcitx-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx-remote -o")
      let g:input_toggle = 0
   endif
endfunction

"set timeoutlen=150
"autocmd InsertLeave * call Fcitx2en()
"autocmd InsertEnter * call Fcitx2zh()

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

