runtime! debian.vim

"if has("syntax")
 syntax on  "语法高亮
"endif
    
"-----原版设置-----

set nu               "在左侧行号
set relativenumber   "显示相对行号
"set cursorline       "突出显示当前行
set ruler            "在右下角显示光标位置的状态行
set autoindent       "自动缩进
set ts=4             "tab键等于4个空格
set shiftwidth=4     "设置当行之间交错时使用4个空格
"set expandtab        "用空格取代tab
set mouse+=a	         " Enable mouse usage (all modes)

"自动补全相关设置
"set completeopt=menu,preview,longest

"显示隐藏字符
set list             "显示空白字符
set listchars=tab:>~,trail:& "设置tab键和行末空格字符样式
"设置空白字符显示的颜色
hi SpecialKey guifg=darkgrey ctermfg=darkgrey  

set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936  "指定编码格式
set termencoding=utf-8
set encoding=utf-8

filetype plugin indent on

"状态栏设置
set laststatus=2      " 总是显示状态栏
"不知道是那个插件设置了状态栏
"我对于状态栏的设置并不会生效

"当要搜索的字符串“”中的所有字符都是小写时，此设置使搜索不区分大小写。
"但是，如果“包含任何大写字母”，搜索就会区分大小写。这使得搜索更加方便
set ignorecase
set smartcase
set incsearch   "在键入时启用搜索，而不是等到按enter键时再进行搜索。

" 取消对于Q的快捷键绑定，
nmap Q <Nop>

set noerrorbells visualbell t_vb=    "禁用vim的提示铃声
set shortmess+=I                     "禁用默认的启动信息

"默认情况下，退格键有一些非直观的行为。
"例如，默认情况下不能在用'i'设置的插入点之前退格。
"这种配置使退格行为更加合理，因为你可以“在任何事情上退格”。
set backspace=indent,eol,start

"omni设置
"set omnifunc=syntaxcomplete#Complete

"-----插件安装-----
call plug#begin('~/.vim/plugged')

"彩虹括号
Plug 'luochen1990/rainbow'
"关键字高亮
Plug 'itchyny/lightline.vim' "gao liang
"自动补全
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"markdown
"Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"verilog 插件，支持语法高亮、自动补全、自动缩进
Plug 'vhda/verilog_systemverilog.vim'
"与光标所选字符相同的字符，显示下划线
Plug 'itchyny/vim-cursorword'
"显示竖线，区分代码等级
Plug 'Yggdroot/indentLine'
"C-T直接打开边栏可以浏览文件和跳转
Plug 'preservim/nerdtree'
"verilog异步语法检测
Plug 'dense-analysis/ale'
"代码对齐
Plug 'godlygeek/tabular'
"轻量级自动补全
Plug 'Shougo/neocomplete.vim'
"文件管理插件，可以新建、打开和搜索文件，也可以完成分屏显示
Plug 'ctrlpvim/ctrlp.vim'

call plug#end()

"-----插件设置-----
"
"
"---rainbow
"开启插件
let g:rainbow_active = 1
"
"---markdown
"let g:mkdp_browser = '/snap/firefox/current/usr/lib/firefox'
let g:mkdp_auto_start = 1

"---verilog_systemverilog.vim
:compiler verilator
"let &makeprg='vlogan +v2k -full64 +vcs+flush+all +lint=all -sverilog +libext+.v+.sv -lca %'
"autocmd BufWritePost *.v exec ":make"
"开启自动补全
let g:SuperTabDefaultCompletionType = 'context'

"---vim-cursorword
"let g:indentLine_setColors = 0
"let g:indentLine_defaultGroup = 'SpecialKey'

"---neocomplete 处于关闭状态
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 0
" Use smartcase.
let g:neocomplete#enable_smart_case = 0

"---CtrlP 设置快捷键
let g:ctrlp_map = '<c-w>'
let g:ctrlp_cmd = 'CtrlP'
"-----按键映射

"调用侧边栏插件，打开或关闭侧边栏。
nnoremap <C-t> :NERDTreeToggle<CR>

"行首加入注释符
fun! Exec(cmd)
    exe a:cmd
    return ''
endf
inoremap <silent><C-l> <c-r>=Exec('norm I//')<cr>
nnoremap <C-l> :s/^/\/\/<cr>

"与外部文件进行复制粘贴
vnoremap <C-y> "+y
nnoremap <C-p> "*p

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
        source /etc/vim/vimrc.local
endif

