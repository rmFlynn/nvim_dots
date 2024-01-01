--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

TODO:
 Add descriptions to fuGitive short cuts
 Apply the Jupiter notebook solution and fix the key bindings

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- "/usr/bin/python3.10'
vim.g.python3_host_prog = '~/.config/nvim/nvim_venv/bin/python3'
vim.g.node_host_prog = '~/.nvm/versions/node/v20.4.0/bin/node'


-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.    const out_schema
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
  --
  -- you know what
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  -- You know what, billing starts june 30
  {
    'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  -- alt
  {
    'Exafunction/codeium.vim',
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set('i', '<C-right>', function() return vim.fn['codeium#Accept']() end,
        { expr = true })
    end
  },
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  },
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
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
  'rhysd/vim-grammarous',


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

  -- Also snakemake stuff I may need
  -- Plug 'snakemake/snakemake', {'rtp': 'misc/vim'}
  -- Plug 'snakemake/snakefmt'

  -- Plugins I used to like and may again
  --Plug 'JuliaEditorSupport/julia-vim'
  -- alt Highlighting
  -- " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
  -- allt command line
  -- Plug 'jalvesaq/vimcmdline'
  -- Plug 'jiangmiao/auto-pairs'
  -- Plug 'scrooloose/nerdtree'  " file list
  -- Plug 'tiagofumo/vim-nerdtree-syntax-highlight'  "to highlight files in nerdtree
  -- Plug 'Vimjas/vim-python-pep8-indent'  "better indenting for python
  -- Plug 'kien/ctrlp.vim'  " fuzzy search files
  -- COC stuf
  -- Plug 'neoclide/coc.nvim', {'branch': 'release'}

  'anott03/nvim-lspinstall',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      -- others
      'f3fora/cmp-spell',
      'hrsh7th/cmp-path'
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-path', },
  },

  -- latext
  'lervag/vimtex',

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',          opts = {} },
  {
    -- Adds git reeated signs to the gutter, as well as utilities for managing changes
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Theme
    'morhetz/gruvbox',
    priority = 1000,
    config = function()
      vim.o.termguicolors = true
      vim.cmd.colorscheme 'gruvbox'
      vim.cmd 'highlight Normal ctermbg=NONE guibg=NONE'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        path = 1,
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- project suport
  -- {
  --   "ahmedkhalf/project.nvim",
  --   config = function()
  --     require("project_nvim").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --    }
  --    end
  -- },


  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- Files
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    'nvim-telescope/telescope-smart-history.nvim',
    dependencies = { "kkharji/sqlite.lua" }
  },
  {
    "nvim-telescope/telescope-project.nvim",
    dependencies = { "nvim-telescope/telescope-file-browser.nvim" }
  },

  {
    "psf/black"
  },
  -- {
  --   'averms/black-nvim'
  -- },
  --
  -- Testing
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim"
    }
  },
  "nvim-neotest/neotest-python",
  "nvim-neotest/neotest-plenary",
  "nvim-neotest/neotest-vim-test",
  "rouge8/neotest-rust",

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      -- optional: setup telescope before loading the extension
      require("telescope").setup {
        -- move this to the place where you call the telescope setup function
        extensions = {
          advanced_git_search = {
            -- fugitive or diffview
            diff_plugin = "fugitive",
            -- customize git in previewer
            -- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
            git_flags = {},
            -- customize git diff in previewer
            -- e.g. flags such as { "--raw" }
            git_diff_flags = {},
            -- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
            show_builtin_git_pickers = false,
            entry_default_author_or_date = "author", -- one of "author" or "date"

            -- Telescope layout setup
            telescope_theme = {
              function_name_1 = {
                -- Theme options
              },
              function_name_2 = "dropdown",
              -- e.g. Realistic example
              show_custom_functions = {
                layout_config = { width = 0.4, height = 0.4 },
              },

            }
          }
        }
      }
      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- optional: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      -- "sindrets/diffview.nvim",
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  { import = 'custom.plugins' },
}, {})



-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

vim.keymap.set('n', '<leader>v', "<c-v>", { silent = true })

vim.keymap.set('n', '<C-J>', "<C-W><C-J>", { silent = true })
vim.keymap.set('n', '<C-K>', "<C-W><C-K>", { silent = true })
vim.keymap.set('n', '<C-L>', "<C-W><C-L>", { silent = true })
vim.keymap.set('n', '<C-H>', "<C-W><C-H>", { silent = true })

-- jukit keymaps
-- --nnoremap <leader>so :call jukit#splits#show_last_cell_output(1)<cr>
-- vim.keymap.set('n', '<leader>jo', ":call jukit#splits#show_last_cell_output(1)", { silent = true })
-- --nnoremap <leader>rpd :call jukit#convert#save_nb_to_file(1,1,'pdf')<cr>
-- vim.keymap.set('n', '<leader>jpdf', ":call jukit#splits#show_last_cell_output(1)", { silent = true })
-- -- vnnoremap <leader>os :call jukit#splits#output()<cr>
-- vim.keymap.set('n', '<leader>jos', ":call jukit#splits#output()<cr>", { silent = true })
-- -- "   - Opens a new output window and executes the command specified in `g:jukit_shell_cmd`
-- -- nnoremap <leader>ts :call jukit#splits#term()<cr>
-- vim.keymap.set('n', '<leader>jts', ":call jukit#splits#term()", { silent = true })
-- -- "   - Opens a new output window without executing any command
-- -- nnoremap <leader>hs :call jukit#splits#history()<cr>
-- vim.keymap.set('n', '<leader>jhs ', ":call jukit#splits#history()", { silent = true })
-- -- "   - Opens a new output-history window, where saved ipython outputs are displayed
-- -- nnoremap <leader>ohs :call jukit#splits#output_and_history()<cr>
-- vim.keymap.set('n', '<leader>johs ', ":call jukit#splits#output_and_history()", { silent = true })
-- -- "   - Shortcut for opening output terminal and output-history
-- -- nnoremap <leader>hd :call jukit#splits#close_history()<cr>
-- vim.keymap.set('n', '<leader>jhd ', ":call jukit#splits#close_history()", { silent = true })
-- -- "   - Close output-history window
-- -- nnoremap <leader>od :call jukit#splits#close_output_split()<cr>
-- vim.keymap.set('n', '<leader>jod ', ":call jukit#splits#close_output_split()", { silent = true })
-- -- "   - Close output window
-- -- nnoremap <leader>ohd :call jukit#splits#close_output_and_history(1)<cr>
-- vim.keymap.set('n', '<leader>johd ', ":call jukit#splits#close_output_and_history(1)", { silent = true })






--Grammer
--
vim.g.grammarous_jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'


-- python-style
vim.g.python_style = 'rest'

-- latext
--
vim.g.vimtex_view_method = 'zathura'

-- enable AutoSave on Vim startup
vim.g.auto_save = 1

-- Maintain undo history between sessions
vim.undofile = true
vim.undodir = '~/.vim/undodir'
-- nnoremap <leader>rc :ReplRunCell<CR>
-- nmap <leader>rr <Plug>ReplSendLine
-- vmap <leader>rr <Plug>ReplSendVisual
-- let cmdline_map_send           = '<Space>'
--let cmdline_map_send_and_stay  = '<LocalLeader><Space>'
--let cmdline_map_source_fun     = '<LocalLeader>f'
--let cmdline_map_send_paragraph = '<LocalLeader>p'
--let cmdline_map_send_block     = '<LocalLeader>b'
--let cmdline_map_quit           = '<LocalLeader>q'

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- " => Spelling stuff
-- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
-- set spelllang=en
-- hi clear SpellBad
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
--

vim.opt.spelloptions = "camel"

require('telescope').setup {
  defaults = {
    history = {
      path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      limit = 100,
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
        ["<C-o>"] = "select_vertical",
        ["<C-S-o>"] = "select_horizontal",
      },
      n = {
        ["<C-o>"] = "select_vertical",
        ["<C-S-o>"] = "select_horizontal",
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        ["i"] = {
          -- your custom insert mode mappings
        },
        ["n"] = {
          -- your custom normal mode mappings
        },
      },
    },
  },
}
require("telescope").load_extension('file_browser')
require('telescope').load_extension('smart_history')
require("telescope").load_extension('project')

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = {git_root},
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>o', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })


require("neotest").setup({
  adapters = {
    require("neotest-python"),
    require("neotest-rust")({
      args = { "--no-capture" },
    }),
    require("neotest-plenary"),
    require("neotest-vim-test")({
      ignore_file_types = { "python", "vim", "lua" },
    }),
  },
})

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sp', require('telescope').extensions.project.project, { desc = '[S]earch [P]rojects' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<leader>so", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { noremap = true })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  pylsp = {},
  rust_analyzer = {},
  tsserver = {},
  html = { filetypes = { 'html', 'twig', 'hbs' } },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = true },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- Set command for fugitive

vim.keymap.set('n', '<leader>gc', ":Git commit<CR>", {})
vim.keymap.set('n', '<leader>gau', ":Git add -u<CR>", { silent = true })
vim.keymap.set('n', '<leader>gaf', ":Git add %<CR>", { silent = true })
vim.keymap.set('n', '<leader>gs', ":Git status<CR>", { silent = true })
vim.keymap.set('n', '<leader>gh', ":Flog<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdd', ":Gvdiffsplit<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdh0', ":Gvdiffsplit HEAD<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdh1', ":Gvdiffsplit HEAD 1<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdh2', ":Gvdiffsplit HEAD 2<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdh3', ":Gvdiffsplit HEAD 3<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdh4', ":Gvdiffsplit HEAD 4<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdh5', ":Gvdiffsplit HEAD 5<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdom', ":Git diff main<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdtm', ":Git difftool main<CR>", { silent = true })
vim.keymap.set('n', '<leader>gdm', ":Gvdiffsplit main<CR>", { silent = true })
vim.keymap.set('n', '<leader>gpl', ":Git pull<CR>", {})
vim.keymap.set('n', '<leader>gps', ":Git push<CR>", {})

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' }
  },
}
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'pylsp' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})


-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

require("lspconfig").pyright.setup {}
require("lspconfig").textlsp.setup {
  analysers = {
    languagetool = {
      enabled = false,
      check_text = {
        on_open = true,
        on_save = true,
        on_change = false,
      }
    },
    gramformer = {
      -- gramformer dependency needs to be installed manually
      enabled = true,
      gpu = false,
      check_text = {
        on_open = false,
        on_save = true,
        on_change = false,
      }
    },
    hf_checker = {
      enabled = true,
      gpu = false,
      model = 'pszemraj/flan-t5-large-grammar-synthesis',
      -- model='pszemraj/grammar-synthesis-large',
      min_length = 40,
      check_text = {
        on_open = false,
        on_save = true,
        on_change = false,
      }
    },
    hf_completion = {
      enabled = true,
      gpu = false,
      model = 'bert-base-multilingual-cased',
      topk = 5,
    },
    openai = {
      enabled = false,
      api_key = '<MY_API_KEY>',
      check_text = {
        on_open = false,
        on_save = false,
        on_change = false,
      },
      -- model = 'text-ada-001',
      model = 'text-babbage-001',
      -- model = 'text-curie-001',
      -- model = 'text-davinci-003',
      edit_model = 'text-davinci-edit-001',
      max_token = 16,
    },
    grammarbot = {
      enabled = false,
      api_key = '<MY_API_KEY>',
      -- longer texts are split, this parameter sets the maximum number of splits per analysis
      input_max_requests = 1,
      check_text = {
        on_open = false,
        on_save = false,
        on_change = false,
      }
    },
  },
  documents = {
    org = {
      org_todo_keywords = {
        'TODO',
        'IN_PROGRESS',
        'DONE'
      },
    },
    txt = {
      parse = true,
    },
  },
}
require("lspconfig").pylsp.setup {
  filetypes = { "python" },
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          enabled = false,
        },
        pyright = {
          enabled = true,
        },
        textlsp = {
          enabled = true,
        },
        isort = {
          enabled = true,
        },
        pydocstyle = {
          ignore = { "D200", "D213", "D203", "D212" },
          enabled = true,
        },
        pycodestyle = {
          maxLineLength = 100
        },
        flake8 = {
          enabled = false,
        },
        black = {
          enabled = true,
          maxLineLength = 100
        },
        ruff = {
          enabled = true,
          maxLineLength = 100
        }
      }
    }
  }
}

-- Try to get black good a proper
--if vim.bo.filetype == "python" then
vim.keymap.set('n', '<esc><esc>', ":Black<CR>:%s/\\s\\+$//e<CR>", { silent = true })
vim.keymap.set('n', '<leader>mh', ":vertical resize -20 <CR>", { silent = true })
vim.keymap.set('n', '<leader>ml', ":vertical resize +20 <CR>", { silent = true })

--vim.g.black_linelength = 80

--vim.cmd(":execute \"set colorcolumn=\" . (&colorcolumn == \"\" ? \"81\" : \"\")")
vim.cmd("set fo+=t")
vim.cmd("set textwidth=87")
--end

-- Key map for reload
vim.keymap.set('n', '<leader>cc', ":tabnew ~/.config/nvim/init.lua  <CR>", { silent = true })

vim.keymap.set('t', "<esc>", "<C-\\><C-n>", { silent = true })

vim.opt.spell = true
vim.opt.spelllang = 'en_us'
-- vim.opt.spelloptions("camel")

-- vim.highlight.create('SpellBad', 'cterm=underline ctermfg=red')
-- hi SpellBad cterm=underline ctermfg=red
require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", -- | top | left | right
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 16.x
  server_opts_overrides = {},
})

-- copy paste
vim.keymap.set('n', 'C-c', "\"+y")

-- Windows helper
in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = { 'clip.exe' },
      ['*'] = { 'clip.exe' },
    },
    paste = {
      ['+'] = {
        'powershell.exe -c [Console]::\'Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))\'' },
      ['*'] = {
        'powershell.exe -c [Console]::\'Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))\'' },
    },
    cache_enabled = 0,
  }
  --     vim.g.clipboard = {
  --         name = 'wsl clipboard',
  --         copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
  --         paste = { ["+"] = { "~/.config/nvim/vim_paste" }, ["*"] = { "~/.config/nvim/vim_paste" } },
  --         cache_enabled = true
  --     }
end
