local lib = require "nvim-tree.lib"
local core = require "nvim-tree.core"
local utils = require "nvim-tree.utils"
local filters = require "nvim-tree.explorer.filters"
local reloaders = require "nvim-tree.actions.reloaders.reloaders"

local M = {}

local function reload()
  local node = lib.get_node_at_cursor()
  reloaders.reload_explorer()
  local explorer = core.get_explorer()

  if explorer == nil then
    return
  end

  while node do
    local found_node, _ = utils.find_node(explorer.nodes, function(node_)
      return node_.absolute_path == node.absolute_path
    end)

    if found_node or node.parent == nil then
      utils.focus_file(node.absolute_path)
      break
    end

    node = node.parent
  end
end

function M.custom()
  filters.config.filter_custom = not filters.config.filter_custom
  reload()
end

function M.git_ignored()
  filters.config.filter_git_ignored = not filters.config.filter_git_ignored
  reload()
end

function M.git_clean()
  filters.config.filter_git_clean = not filters.config.filter_git_clean
  reload()
end

function M.no_buffer()
  filters.config.filter_no_buffer = not filters.config.filter_no_buffer
  reload()
end

function M.dotfiles()
  filters.config.filter_dotfiles = not filters.config.filter_dotfiles
  reload()
end

return M
