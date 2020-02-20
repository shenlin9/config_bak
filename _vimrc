set nocompatible

"--------------------插件管理--------------------

call plug#begin()

" colorscheme
Plug 'morhetz/gruvbox'

" 状态条
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Go 引擎 
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Markdown,第一个插件是下面的插件要调用到的
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

" 自动完成
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" 中英文排版时加空格
Plug 'hotoo/pangu.vim'

" 代码对齐
Plug 'junegunn/vim-easy-align'

" 括号、引号等自动配对
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'

" . 的增强版
Plug 'tpope/vim-repeat'

call plug#end()


"--------------------colorscheme--------------------

"设置配色方案
"必须有这一行
"set t_Co=256
"否则单这一行出错
"colorscheme solarized
"let g:solarized_termcolors=256

set background=dark
colorscheme gruvbox

"----------------------------------------------------------------
let mapleader = ";"

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
    set guifont=等距更纱黑体_TC_LIGHT:h11
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
nmap <C-/> I// <Esc>

"中英文空格
"command Spa s/\v(\s?\w+\s?)/ \1 /g

"Format Markdown
"command Fmd s/“/ `/g|s/”/` /g|s/（/(/g|s/）/)/g|s/,/，/g|s/./。/g|s/;/；/g|s/' / `/g|s/ '/` /g
"command Fmd s/' / `/g|s/ '/` /g|s/“/ `/g|s/”/` /g|s/（/(/g|s/）/)/g|s/,/，/g|s/./。/g|s/;/；/g

"Quote Uppercase
"command Quc s/\v (\u+)[ ,.]/ `\1` /g

"Write Markdown
"command Wmd w 文件名.md

" 编辑配置文件
command Rc e $HOME\\_vimrc
" 重新加载配置文件
command So source $HOME\\_vimrc
" 新文件
command E enew

"折叠代码中的 class、function 等代码块
set foldmethod=indent
set foldlevel=99

"更改折叠代码块默认的快捷键
nnoremap <Space> za
nnoremap [<Space> O<ESC>j
nnoremap ]<Space> o<ESC>k
nnoremap [] O<ESC>jo<ESC>k

"vim-surround 添加双引号快捷键
nmap [" ysiw"
nmap [' ysiw'
nmap [[ ysiw[

" 启用命令行自动补全增强模式
set wildmenu
set wildmode=longest:list,full

" 启用智能感知
set omnifunc=syntaxcomplete#Complete
" imap <silent> ` <C-X><C-O>

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
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <C-X> :bdelete<CR>

" autowrite
set autowrite

" undo 设置
set hidden

" Persistent undo
set undofile
set undodir=$HOME/.vim/undo

set undolevels=1000
set undoreload=10000

set backspace=indent,eol,start

" 超长换行快捷键
"nmap , VQ
" 搜索后去除高亮
nmap <BackSpace> :nohl<cr>

" 中文模式下输入的 ·改为英文的 `
" 主要用于 markdown 的代码块，避免切换输入法
imap · `
imap （ (
imap ） )
imap ？ ?
imap ‘ '
imap ’ '

" gvimfullscreen  ==========================================================={{{
" https://github.com/asins/gvimfullscreen_win32
" 将 gvimfullscreen.dll 复制到gvim安装目录下，与gvim.exe同目录
" {{{ Win平台下窗口全屏组件 gvimfullscreen.dll
" Alt + Enter 全屏切换
" Shift + t 降低窗口透明度
" Shift + y 加大窗口透明度
" Shift + r 切换Vim是否总在最前面显示
" Vim启动的时候自动使用当前颜色的背景色以去除Vim的白色边框
if has('gui_running') && has('gui_win32') && has('libcall')
    let g:MyVimLib = 'gvimfullscreen.dll'
    function! ToggleFullScreen()
        call libcall(g:MyVimLib, 'ToggleFullScreen', 1)
    endfunction

    let g:VimAlpha = 245
    function! SetAlpha(alpha)
        let g:VimAlpha = g:VimAlpha + a:alpha
        if g:VimAlpha < 180
            let g:VimAlpha = 180
        endif
        if g:VimAlpha > 255
            let g:VimAlpha = 255
        endif
        call libcall(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    endfunction

    let g:VimTopMost = 0
    function! SwitchVimTopMostMode()
        if g:VimTopMost == 0
            let g:VimTopMost = 1
        else
            let g:VimTopMost = 0
        endif
        call libcall(g:MyVimLib, 'EnableTopMost', g:VimTopMost)
    endfunction

    " 映射 shift+Enter 切换全屏vim
    map <s-enter> <esc>:call ToggleFullScreen()<cr>
    " 切换Vim是否在最前面显示
    "nmap <s-r> <esc>:call SwitchVimTopMostMode()<cr>
    " 增加Vim窗体的不透明度
    "nmap <s-t> <esc>:call SetAlpha(10)<cr>
    " 增加Vim窗体的透明度
    "nmap <s-y> <esc>:call SetAlpha(-10)<cr>

    " 默认设置透明
    autocmd GUIEnter * call libcallnr(g:MyVimLib, 'SetAlpha', g:VimAlpha)
    " 默认全屏
    "autocmd GUIEnter * call libcallnr(g:MyVimLib, 'ToggleFullScreen', 1)
endif

" }}}


" lightline setup ==========================================================={{{

let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#number_map = {
\ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
\ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'}

let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:lightline#bufferline#modified = ' *'
let g:lightline#bufferline#filename_modifier = ':t'
"let g:lightline#bufferline#enable_devicons = 1

let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

set showtabline=2
if has('gui_running')
    set guioptions-=e " Don’t use GUI tabline
endif
set laststatus=2  " Basic

" }}}

" coc-list lightline setup =================================================={{{
"let g:lightline = {
"\ 'colorscheme': 'wombat',
"\ 'active': {
"\   'left': [ [ 'mode', 'paste' ],
"\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
"\ },
"\ 'component_function': {
"\   'cocstatus': 'coc#status'
"\ },
"\ }
"
"autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" }}}
"

"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'
"autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" coc.nvim================================================================={{{
"
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
elseif (index(['go'], &filetype) >= 0)
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
"nnoremap <silent> <space>g :<C-u>CocList --normal gstatus<CR>
nnoremap <silent> <space>g :<C-u>CocList<CR>
nnoremap <silent> <space>m :<C-u>CocList mru<CR>
nnoremap <silent> <space>b :<C-u>CocList buffers<CR>
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"}}}


" coc-snippets=========================================={{{
"
" Use <C-l> for trigger snippet expand.
"imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

"}}}

" Pangu 自动规范化中英文
"autocmd BufWritePre *.markdown,*.md,*.text,*.txt,*.wiki,*.cnx call PanGuSpacing()

" Vim-Easy-Align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" 可视模式下不包含最后的换行符
vmap gm gmh
vmap $ $h

" 启用 Vim 自带的代码块高亮显示
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:markdown_syntax_conceal = 0
let g:markdown_minlines = 100


" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1

