" Basic mode of SpaceVim, generated by SpaceVim automatically.
let g:spacevim_enable_guicolors = 0
let g:spacevim_statusline_separator = 'nil'
let g:spacevim_statusline_inactive_separator = 'bar'
let g:spacevim_buffer_index_type = 4
let g:spacevim_enable_tabline_filetype_icon = 0

"加载 php layer
call SpaceVim#layers#load("lang#php","lang#markdown","ui")

"修改默认插件管理器
"let g:spacevim_plugin_manager = 'vim-plug'

"禁用默认启用的插件
let g:spacevim_disabled_plugins = ['vim-chat', 'lang#go']

"日志只记录错误和警告 1.全部 2.警告和错误 3错误
call SpaceVim#logger#setLevel(2)

"github用户名，用于获取收藏的库
let g:spacevim_github_username = "shenlin9"
"禁用  powerline 字体，因为没装
let g:spacevim_enable_powerline_fonts = 0
"定义字体，SpaceVim 的默认字体没有安装会报错
let g:spacevim_guifont = 'DejaVu\ Sans\ Mono:h10:w5'
"定义帮助语言
let g:spacevim_vim_help_language = 'chinese'
"================================================================
"
"定义vimfiler位置 topleft or rightbelow
let g:vimfiler_direction = 'topleft'
"自动切换到编辑文件的目录
let g:vimfiler_enable_auto_cd = 1
"设置 vimfiler 为系统默认的文件浏览器
let g:vimfiler_as_default_explorer = 1
"call VimFiler#custom#profile('default', 'context', {
"      \ 'direction' : 'topleft',
"      \ 'enable_auto_cd' : 1
"      \ })
"
"================================================================

"不产生备份文件
"set nobackup
"不产生撤销文件
"set noundofile
"不产生swp临时文件
"set noswapfile

"没有字节序标记Byte Order Mark 
set nobomb
"检测文件编码顺序
set fileencodings=ucs-bom,utf-8,cp936,gb2312,gb18030,big5,euc-jp,euc-kr,latinl
"设置vim终端显示编码
set termencoding=utf8
"设置vim内部编码
set encoding=utf8
"设置写入文件时编码
set fileencoding=utf8

"设置文件的换行格式
set fileformats=unix,dos
set fileformat=unix

" 窗口启动时自动最大化
au GUIEnter * simalt ~x

"切换到笔记目录
":VimFiler d:\git\shenlin.ltd.git\source\_posts
"call vimfiler#set_execute_file('txt', 'notepad')

"打开上次的文件
"au VimLeave * mks! $HOME/Session.vim
"if expand("%")==""
"    if(expand("$HOME/Session.vim")==findfile(expand("$HOME/Session.vim")))
"         silent :source $HOME/Session.vim
"    endif
"endif
"
"普通模式和插入模式 Ctrl+Insert 也是复制
:nmap <C-Insert> "*Y
:imap <C-Insert> "*Y






