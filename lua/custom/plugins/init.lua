-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Copilot Lua
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

  'anott03/nvim-lspinstall',

  -- latext
  'lervag/vimtex',


  config = function()
    -- "/usr/bin/python3.10'
    vim.g.python3_host_prog = '~/.config/nvim/nvim_venv/bin/python3'
    vim.g.node_host_prog = '~/.nvm/versions/node/v20.4.0/bin/node'
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

    -- " => Spelling stuff
    -- """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    vim.opt.spelloptions = "camel"

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
  end,

}
