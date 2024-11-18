-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Copilot Lua
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },

  -- alt
  {
    'Exafunction/codeium.vim',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-right>', function() return vim.fn['codeium#Accept']() end,
        { expr = true })
    end
  },
  -- {
  --   "piersolenski/wtf.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   event = "VeryLazy",
  --   opts = {},
  --   keys = {
  --     {
  --       "gw",
  --       mode = { "n" },
  --       function()
  --         require("wtf").ai()
  --       end,
  --       desc = "Debug diagnostic with AI",
  --     },
  --     {
  --       mode = { "n" },
  --       "gW",
  --       function()
  --         require("wtf").search()
  --       end,
  --       desc = "Search diagnostic with Google",
  --     },
  --   },
  -- },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
  -- Git related plugins
  'rbong/vim-flog',

  -- DS plugins
  -- This is for Jupiter
  -- 'luk400/vim-jukit',
  -- "jupynium"
  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- other plugins that I like
  -- 'chrisbra/csv.vim',
  -- 'jalvesaq/vimcmdline',
  'pixelneo/vim-python-docstring',
  'chrisbra/Colorizer',

  -- Auto save!!!!!
  '907th/vim-auto-save',

  -- Spelling and Grammar, needs java-jre and zip
  --  'rhysd/vim-grammarous',


  -- Coverage
  -- 'kalekseev/vim-coverage.py', { 'do': ':UpdateRemotePlugins' }

  {
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    -- Optional: needed for PHP when using the cobertura parser
    rocks = { 'lua-xmlreader' },
    config = function()
      require("coverage").setup()
    end,
  },
  'vim-test/vim-test',
  {
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon'
    },
    cmd = {
      'RainbowDelim',
      'RainbowDelimSimple',
      'RainbowDelimQuoted',
      'RainbowMultiDelim'
    }
  },

  'anott03/nvim-lspinstall',

  -- latext
  'lervag/vimtex',


  config = function()
  end,

}
