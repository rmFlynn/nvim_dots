-- jupyter.lua
--
-- Make jupyter notebooks faster
--
return {
  -- see https://github.com/jmbuhr/quarto-nvim-kickstarter/blob/main/lua/plugins/quarto.lua
  {
    "quarto-dev/quarto-nvim",
    dev = false,
    dependencies = {
        "jmbuhr/otter.nvim",
    },
  },
  -- "jupynium"
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install .",
    on_attach = function(buf_id)
        vim.keymap.set(
          { "n", "x" },
          "<cmd-return>",
          "<cmd>JupyniumExecuteSelectedCells<CR>",
          { buffer = buf_id, desc = "Jupynium execute selected cells" }
        )
        vim.keymap.set(
          { "n", "x" },
          "<leader>jc",
          "<cmd>JupyniumClearSelectedCellsOutputs<CR>",
          { desc = "Jupynium clear selected cells" }
        )
        vim.keymap.set(
          { "n" },
          "<leader>jK",
          "<cmd>JupyniumKernelHover<cr>",
          { buffer = buf_id, desc = "Jupynium hover (inspect a variable)" }
        )
        vim.keymap.set(
          { "n", "x" },
          "<leader>js",
          "<cmd>JupyniumScrollToCell<cr>",
          { buffer = buf_id, desc = "Jupynium scroll to cell" }
        )
        vim.keymap.set(
          { "n", "x" },
          "<leader>jo",
          "<cmd>JupyniumToggleSelectedCellsOutputsScroll<cr>",
          { buffer = buf_id, desc = "Jupynium toggle selected cell output scroll" }
        )
        vim.keymap.set("", "<PageUp>", "<cmd>JupyniumScrollUp<cr>", { buffer = buf_id, desc = "Jupynium scroll up" })
        vim.keymap.set("", "<PageDown>", "<cmd>JupyniumScrollDown<cr>", { buffer = buf_id, desc = "Jupynium scroll down" })
    end,
  },
  "rcarriga/nvim-notify",   -- optional
  "stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
  config = function()

  end,
}
