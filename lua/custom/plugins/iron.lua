-- iron.lua
--
-- Adds all iron con fig
--
return {
  -- repl
  'hkupty/iron.nvim',
  config = function()
    local iron = require("iron.core")
    local view = require("iron.view")
    -- One can always use the default commands from vim directly

    iron.setup {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "bash" }
          },
          ps = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "powershell" }
          },
	  -- ipython = require("iron.fts.python").ipython,
          python = {
             command = {"ipython", "--simple-prompt"},
             -- format = require("iron.fts.python").ipython,
             ignore_blank_lines = false, -- ignore blank lines when sending visual select lines
          },
        },
        repl_open_cmd = view.split.vertical.botright()
        -- How the repl window will be displayed
        -- See below for more information
        --repl_open_cmd = require('iron.view').split().right(),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        send_motion = "<shift-space>",
        visual_send = "<space>",
        send_file = "<leader>ra",
        -- send_line = "<space>",
        send_mark = "<leader>rs",
        mark_motion = "<leader>rm",
        mark_visual = "<leader>rm",
        remove_mark = "<leader>ru",
        cr = "<leader>r<cr>",
        interrupt = "<leader>ri",
        exit = "<leader>rq",
        clear = "<leader>rc",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true
      },
    }

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set('n', '<space>', '<Cmd>lua require("iron").core.send_line()<cr><cr>')
    vim.keymap.set('n', '<leader>rt', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<leader>rb', '<cmd>IronRepl sh<cr><cmd>IronAttach sh<cr>')
    vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl ps<cr><cmd>IronAttach ps<cr>')
    vim.keymap.set('n', '<leader>rp', '<cmd>IronRepl python<cr><cmd>IronAttach ipython<cr>')
    vim.keymap.set('n', '<leader><space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<leader><space>rf', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<leader><space>rh', '<cmd>IronHide<cr>')
  end,
}
  -- NOTE: Yes, you can install new plugins here!
