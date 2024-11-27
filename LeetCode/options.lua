-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.cmd [[
set mouse=a
set mousemodel=extend
set updatetime=400
set nu nornu ru ls=2
set et sts=0 ts=4 sw=4
set signcolumn=number
set nohls
set listchars=tab:▸\ ,trail:⋅,extends:❯,precedes:❮
set cinoptions=j1,(0,ws,Ws,g0,:0,=0,l1
set cinwords=if,else,switch,case,for,while,do
set showbreak=↪
set list
set clipboard+=unnamedplus
set exrc
set foldtext='+--'
set bri wrap
set cc=80
set termguicolors
]]
