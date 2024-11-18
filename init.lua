--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

TODO:
 Add descriptions to fuGitive short cuts

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
vim.g.python_host_prog = "C:/Users/rory_flynn/AppData/Local/Programs/Python/Python312/python.exe"
vim.g.sqlite_clib_path = "C:/Users/rory_flynn/AppData/Local/nvim/nvim-win64/bin/sqlite3.dll"
vim.cmd("filetype plugin on")

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
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- sql
  'nanotee/sqls.nvim',
  -- {
  --  'autozimu/LanguageClient-neovim',
  --   --{
  --    --'branch': 'next',
  --    --'do': 'bash install.sh',
  --   --},
  --   dependencies =  {'junegunn/fzf'}
  -- },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  -- dbt
  {
    "PedramNavid/dbtpal",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    ft = {
        "sql",
        "md",
        "yaml",
    },
    keys = {
        { "<leader>drf", "<cmd>DbtRun<cr>" },
        { "<leader>drp", "<cmd>DbtRunAll<cr>" },
        { "<leader>dtf", "<cmd>DbtTest<cr>" },
        { "<leader>dm", "<cmd>lua require('dbtpal.telescope').dbt_picker()<cr>" },
    },
    config = function()
        require("dbtpal").setup({
            path_to_dbt = "dbt",
            path_to_dbt_project = "",
            path_to_dbt_profiles_dir = vim.fn.expand("~/.dbt"),
            extended_path_search = true,
            protect_compiled_files = true,
        })
        require("telescope").load_extension("dbtpal")
    end,
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
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',

      -- Adds spelling.
      'f3fora/cmp-spell',
      -- Adds paths ok.
      'hrsh7th/cmp-path',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
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
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },

  {
    -- Theme the good one
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

  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
  "kkharji/sqlite.lua",
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
  require 'custom.plugins.jupyter',
  require 'custom.plugins.init',
  require 'custom.plugins.iron',
{
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  build = function()
    -- Install tries to automatically detect the install method.
    -- if it fails, try calling it with one of these parameters:
    --    "curl", "wget", "bitsadmin", "go"
    require("dbee").install()
  end,
  config = function()
    require("dbee").setup(--[[optional config]])
  end,
},
  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
  { import = 'custom.plugins' },
}, {}


)

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

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    history = {
      -- path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
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
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
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

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
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
require('nvim-treesitter.install').compilers = { 'zig' }
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    -- highlight = { enable = true }, -- You cant use this idk why
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
  ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

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
      -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      -- diagnostics = { disable = { 'missing-fields' } },
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

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
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
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
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
    { name = 'path' },
  },
}

    -- "/usr/bin/python3.10'
    -- vim.g.python3_host_prog = '~/.config/nvim/nvim_venv/bin/python3'
    -- vim.g.node_host_prog = '~/.nvm/versions/node/v20.4.0/bin/node'
    vim.keymap.set('n', '<leader>v', "<c-v>", { silent = true })

    vim.keymap.set('n', '<C-J>', "<C-W><C-J>", { silent = true })
    vim.keymap.set('n', '<C-K>', "<C-W><C-K>", { silent = true })
    vim.keymap.set('n', '<C-L>', "<C-W><C-L>", { silent = true })
    vim.keymap.set('n', '<C-H>', "<C-W><C-H>", { silent = true })


    --Grammer
    --
    -- vim.g.grammarous_jar_url = 'https://www.languagetool.org/download/LanguageTool-5.9.zip'


    -- python-style
    vim.g.python_style = 'google'

    -- latext
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

    -- " => Spelling stuff
    -- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    vim.opt.spelloptions = "camel"

    local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
    vim.keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
    vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

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

    -- Diagnostic keymaps
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
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
--    require("lspconfig").textlsp.setup {
--       analysers = {
--         languagetool = {
--           enabled = false,
--           check_text = {
--             on_open = true,
--             on_save = true,
--             on_change = false,
--           }
--         },
--         gramformer = {
--           -- gramformer dependency needs to be installed manually
--           enabled = true,
--           gpu = false,
--           check_text = {
--             on_open = false,
--             on_save = true,
--             on_change = false,
--           }
--         },
--         hf_checker = {
--           enabled = true,
--           gpu = false,
--           model = 'pszemraj/flan-t5-large-grammar-synthesis',
--           -- model='pszemraj/grammar-synthesis-large',
--           min_length = 40,
--           check_text = {
--             on_open = false,
--             on_save = true,
--             on_change = false,
--           }
--         },
--         hf_completion = {
--           enabled = true,
--           gpu = false,
--           model = 'bert-base-multilingual-cased',
--           topk = 5,
--         },
--         openai = {
--           enabled = false,
--           api_key = '<MY_API_KEY>',
--           check_text = {
--             on_open = false,
--             on_save = false,
--             on_change = false,
--           },
--           -- model = 'text-ada-001',
--           model = 'text-babbage-001',
--           -- model = 'text-curie-001',
--           -- model = 'text-davinci-003',
--           edit_model = 'text-davinci-edit-001',
--           max_token = 16,
--         },
--         grammarbot = {
--           enabled = false,
--           api_key = '<MY_API_KEY>',
--           -- longer texts are split, this parameter sets the maximum number of splits per analysis
--           input_max_requests = 1,
--           check_text = {
--             on_open = false,
--             on_save = false,
--             on_change = false,
--           }
--         },
--       },
--       documents = {
--         org = {
--           org_todo_keywords = {
--             'TODO',
--             'IN_PROGRESS',
--             'DONE'
--           },
--         },
--         txt = {
--           parse = true,
--         },
--       },
--     }
require("lspconfig").pylsp.setup {
  filetypes = { "python" },
  on_attach = on_attach,
  flags = lsp_flags,
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          enabled = true,
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
function FormatFile()
  if vim.bo.filetype == 'python' then
    vim.cmd('Black<CR>:%s/\\s\\+$//e')
  elseif vim.bo.filetype == 'sql' then
  else
    FormatFunction()
  end
end
-- Try to get black good a proper
--if vim.bo.filetype == "python" then
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
    require("jupynium").setup({
      --- For Conda environment named "jupynium",
      -- python_host = { "conda", "run", "--no-capture-output", "-n", "jupynium", "python" },
      python_host = "C:\\Users\\rory_flynn\\AppData\\Local\\Programs\\Python\\Python312\\python.exe",

      default_notebook_URL = "localhost:8888/nbclassic",

      -- Write jupyter command but without "notebook"
      -- When you call :JupyniumStartAndAttachToServer and no notebook is open,
      -- then Jupynium will open the server for you using this command. (only when notebook_URL is localhost)
      jupyter_command = "jupyter",
      --- For Conda, maybe use base environment
      --- then you can `conda install -n base nb_conda_kernels` to switch environment in Jupyter Notebook
      -- jupyter_command = { "conda", "run", "--no-capture-output", "-n", "base", "jupyter" },

      -- Used when notebook is launched by using jupyter_command.
      -- If nil or "", it will open at the git directory of the current buffer,
      -- but still navigate to the directory of the current buffer. (e.g. localhost:8888/nbclassic/tree/path/to/buffer)
      notebook_dir = nil,

      -- Used to remember the last session (password etc.).
      -- e.g. '~/.mozilla/firefox/profiles.ini'
      -- or '~/snap/firefox/common/.mozilla/firefox/profiles.ini'
      firefox_profiles_ini_path = nil,
      -- nil means the profile with Default=1
      -- or set to something like 'default-release'
      firefox_profile_name = nil,

      -- Open the Jupynium server if it is not already running
      -- which means that it will open the Selenium browser when you open this file.
      -- Related command :JupyniumStartAndAttachToServer
      auto_start_server = {
        enable = false,
        file_pattern = { "*.ju.*" },
      },

      -- Attach current nvim to the Jupynium server
      -- Without this step, you can't use :JupyniumStartSync
      -- Related command :JupyniumAttachToServer
      auto_attach_to_server = {
        enable = true,
        file_pattern = { "*.ju.*", "*.md" },
      },

      -- Automatically open an Untitled.ipynb file on Notebook
      -- when you open a .ju.py file on nvim.
      -- Related command :JupyniumStartSync
      auto_start_sync = {
        enable = false,
        file_pattern = { "*.ju.*", "*.md" },
      },

      -- Automatically keep filename.ipynb copy of filename.ju.py
      -- by downloading from the Jupyter Notebook server.
      -- WARNING: this will overwrite the file without asking
      -- Related command :JupyniumDownloadIpynb
      auto_download_ipynb = true,

      -- Automatically close tab that is in sync when you close buffer in vim.
      auto_close_tab = true,

      -- Always scroll to the current cell.
      -- Related command :JupyniumScrollToCell
      autoscroll = {
        enable = true,
        mode = "always", -- "always" or "invisible"
        cell = {
          top_margin_percent = 20,
        },
      },

      scroll = {
        page = { step = 0.5 },
        cell = {
          top_margin_percent = 20,
        },
      },

      -- Files to be detected as a jupynium file.
      -- Add highlighting, keybindings, commands (e.g. :JupyniumStartAndAttachToServer)
      -- Modify this if you already have lots of files in Jupytext format, for example.
      jupynium_file_pattern = { "*.ju.*" },

      use_default_keybindings = true,
      textobjects = {
        use_default_keybindings = true,
      },

      syntax_highlight = {
        enable = true,
      },

      -- Dim all cells except the current one
      -- Related command :JupyniumShortsightedToggle
      shortsighted = false,

      -- Configure floating window options
      -- Related command :JupyniumKernelHover
      kernel_hover = {
        floating_win_opts = {
          max_width = 84,
          border = "none",
        },
      },




    })

    -- You can link highlighting groups.
    -- This is the default (when colour scheme is unknown)
    -- Try with CursorColumn, Pmenu, Folded etc.
    vim.cmd [[
    hi! link JupyniumCodeCellSeparator CursorLine
    hi! link JupyniumMarkdownCellSeparator CursorLine
    hi! link JupyniumMarkdownCellContent CursorLine
    hi! link JupyniumMagicCommand Keyword
    ]]

    -- Please share your favourite settings on other colour schemes, so I can add defaults.
    -- Currently, tokyonight is supported.
    local cmp = require "cmp"
    local compare = cmp.config.compare

    cmp.setup {
      sources = {
        { name = "jupynium", priority = 1000 },  -- consider higher priority than LSP
        { name = "nvim_lsp", priority = 100 },
        -- ...
      },
      sorting = {
        priority_weight = 1.0,
        comparators = {
          compare.score,            -- Jupyter kernel completion shows prior to LSP
          compare.recently_used,
          compare.locality,
          -- ...
        },
      },
    }
