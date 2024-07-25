-- [nfnl] Compiled from fnl/config/keymaps.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("utils")
local merge = _local_1_["merge"]
local _local_2_ = require("keymap")
local map = _local_2_["map"]
map({"n", "x"}, "j", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "<Down>", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "k", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
map({"n", "x"}, "<Up>", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})
map("n", "<S-h>", "<cmd>bprevious<cr>", {desc = "Prev Buffer"})
map("n", "<S-l>", "<cmd>bnext<cr>", {desc = "Next Buffer"})
map({"i", "n"}, "<esc>", "<cmd>noh<cr><esc>", {desc = "Escape and Clear hlsearch"})
map("n", "<leader>dk", vim.diagnostic.goto_prev, {desc = "[D]iagnostics previous"})
map("n", "<leader>dj", vim.diagnostic.goto_next, {desc = "[D]iagnostics next"})
map("n", "<leader>dl", vim.diagnostic.open_float, {desc = "[D]iagnostics line"})
local _local_3_ = require("nfnl.module")
local autoload = _local_3_["autoload"]
local core = autoload("nfnl.core")
local function vim_opt(option, value)
  return core.assoc(vim.o, option, value)
end
local function _4_()
  return vim_opt("expandtab", not vim.o.expandtab)
end
map("n", "<leader>tt", _4_, {desc = "[T]oggle [T]abs as spaces"})
return {}
