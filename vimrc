" PLUGIN CONFIGURATION =============================
call plug#begin('~/.vim/plugged')
Plug 'L9'
" Colors ============================
Plug 'michalbachowski/vim-wombat256mod'
Plug 'crusoexia/vim-monokai'
Plug 'preocanin/greenwint'
Plug 'prognostic/plasticine'
"====================================
Plug 'mg979/vim-visual-multi'
Plug 'itchyny/lightline.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
"snippets --------------------
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
"-----------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'searchfold.vim'
Plug 'godlygeek/tabular' "Must load before vim-markdown (see :h vim-markdown)
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'AndrewRadev/switch.vim'
Plug 'ack.vim'
Plug 'taglist.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-surround'
Plug 'plasticboy/vim-markdown'
Plug 'DrawIt'
Plug 'tpope/vim-unimpaired'
Plug 'atweiden/vim-dragvisuals'
Plug 'sim590/vim-listtrans'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-eunuch'
Plug 'Valloric/YouCompleteMe', { 'do' : './install.py --clang-completer --cs-completer' }
Plug 'rdnetto/YCM-Generator', 'stable'
Plug 'Xe/lolcode.vim'
Plug 'aaronbieber/vim-quicktask'
Plug 'TaskList.vim'
Plug 'mhinz/vim-startify'
Plug 'Raimondi/delimitMate'
" vim-radical & dependencies ---
Plug 'google/vim-maktaba'
Plug 'glts/vim-magnum'
Plug 'glts/vim-radical'
" ------------------------------
Plug 'vim-auto-save', 'noautocmd'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
if has('nvim')
  Plug 'floobits/floobits-neovim'
endif
Plug 'jamessan/vim-gnupg'
Plug 'tomlion/vim-solidity'
Plug 'eagletmt/neco-ghc'
Plug 'lervag/vimtex'
Plug 'dpelle/vim-LanguageTool'
Plug 'aymericbeaumet/symlink.vim'
Plug 'fatih/vim-go'
" Haskell ------------------------------
Plug 'neovimhaskell/haskell-vim'
Plug 'neoclide/coc.nvim', {
      \ 'branch' : 'release'
      \ }
" --------------------------------------
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'cespare/vim-toml'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" vim-AdvancedDiffOptions ------------------
Plug 'inkarkat/vim-AdvancedDiffOptions'
Plug 'inkarkat/vim-ingo-library'
" ------------------------------------------
Plug 'romainl/vim-qf'
Plug 'will133/vim-dirdiff'
call plug#end()

filetype plugin indent on
syntax on

" mapleader is set to tabulation (<tab>)
let mapleader="	"
let maplocalleader="\\"
let g:programming_fts = [
      \ "c",
      \ "cpp",
      \ "python",
      \ "pyrex",
      \ "go",
      \ "haskell",
      \ "prolog",
      \ "lua",
      \ "php",
      \ "js",
      \ "html",
      \ "css",
      \ "cs",
      \ "java",
      \ "sh",
      \ "vim",
      \ "cmake",
      \ "make"
      \ ]
let g:txtformating_fts = [
      \ "tex",
      \ "markdown",
      \ "rst"
      \ ]
let g:syntaxed_fts = g:txtformating_fts + g:programming_fts

source ~/.vim/utilities.vim

" COLORSCHEME ==========
MyColorscheme wombat256mod
" ======================

" OTHER FILES ===================
source ~/.vim/options.vim
source ~/.vim/abbreviations.vim
source ~/.vim/mappings.vim
" ===============================

" PLUGIN SETTINGS ==================================
let s:settings_dir="~/.vim/plugins-config/"
let s:configs = [
      \ "taglist.vim",
      \ "pyclewn.vim",
      \ "vim-multi-cursor.vim",
      \ "ack.vim",
      \ "fugitive.vim",
      \ "snipMate.vim",
      \ "ultisnips.vim",
      \ "pi_netrw.vim",
      \ "dragvisuals.vim",
      \ "jedi-vim.vim",
      \ "quicktask.vim",
      \ "listtrans.vim",
      \ "fzf.vim",
      \ "markdown.vim",
      \ "youcompleteme.vim",
      \ "auto-save.vim",
      \ "pandoc.vim",
      \ "switch.vim",
      \ "neco-ghc.vim",
      \ "lightline.vim",
      \ "tabular.vim",
      \ "vimtex.vim",
      \ "languagetool.vim",
      \ "haskell-conceal.vim"
      \ ]

for s:plugin in s:configs
    execute ":source " . s:settings_dir . s:plugin
endfor
" ==================================================

" vim:set et sw=2 ts=2 tw=100:

