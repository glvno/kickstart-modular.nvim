-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'HiPhish/rainbow-delimiters.nvim',
    enabled = true,
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = 'UIEnter',
    init = function()
      vim.cmd [[
		au ColorScheme gruvbox-material highlight link RainbowDelimiterRed Error
		au ColorScheme gruvbox-material highlight link RainbowDelimiterOrange Title
		au ColorScheme gruvbox-material highlight link RainbowDelimiterYellow Type
		au ColorScheme gruvbox-material highlight link RainbowDelimiterGreen Character
		au ColorScheme gruvbox-material highlight link RainbowDelimiterCyan DiagnosticSignOk
		au ColorScheme gruvbox-material highlight link RainbowDelimiterBlue DiagnosticSignInfo
		au ColorScheme gruvbox-material highlight link RainbowDelimiterViolet Number

		au ColorScheme everforest highlight link RainbowDelimiterRed Error
		au ColorScheme everforest highlight link RainbowDelimiterOrange Title
		au ColorScheme everforest highlight link RainbowDelimiterYellow Type
		au ColorScheme everforest highlight link RainbowDelimiterGreen Character
		au ColorScheme everforest highlight link RainbowDelimiterCyan DiagnosticSignOk
		au ColorScheme everforest highlight link RainbowDelimiterBlue DiagnosticSignInfo
		au ColorScheme everforest highlight link RainbowDelimiterViolet Number


		au ColorScheme seoul256 highlight link RainbowDelimiterRed Error
		au ColorScheme seoul256 highlight link RainbowDelimiterOrange Title
		au ColorScheme seoul256 highlight link RainbowDelimiterYellow Type
		au ColorScheme seoul256 highlight link RainbowDelimiterGreen Character
		au ColorScheme seoul256 highlight link RainbowDelimiterCyan DiagnosticSignOk
		au ColorScheme seoul256 highlight link RainbowDelimiterBlue DiagnosticSignInfo
		au ColorScheme seoul256 highlight link RainbowDelimiterViolet Number
		]]
    end,
    config = function()
      -- This module contains a number of default definitions
      local rainbow_delimiters = require 'rainbow-delimiters'
      vim.g.rainbow_delimiters = {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          -- vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterOrange',
          'RainbowDelimiterYellow',
          'RainbowDelimiterGreen',
          'RainbowDelimiterCyan',
          'RainbowDelimiterBlue',
          'RainbowDelimiterViolet',
        },
      }
    end,
  },

  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure hop the way you like here; see :h hop-config
      require('hop').setup { keys = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' }
      local hop = require 'hop'

      vim.keymap.set('n', 's', function() hop.hint_char1 { direction = nil } end, { remap = true })

      vim.keymap.set('x', 's', function() hop.hint_char1 { direction = nil } end, { remap = true })
    end,
  },

  {
    'windwp/nvim-ts-autotag',
    config = function() require('nvim-ts-autotag').setup {} end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    config = function()
      require('bufferline').setup { options = { show_tab_indicators = true } }

      local bufferline = require 'bufferline'
      vim.keymap.set('n', '<leader>bp', bufferline.pick_buffer)
      vim.keymap.set('n', '<leader>bk', bufferline.close_buffer_with_pick)
    end,
  },
  {
    'sainnhe/gruvbox-material',
    config = function() vim.cmd.colorscheme 'everforest' end,
  },
  { 'sainnhe/everforest' },
  { 'shaunsingh/seoul256.nvim' },
  {
    'sindrets/diffview.nvim',
    -- dependencies = 'nvim-lua/plenary.nvim',
    --
    -- config = function()
    -- 	require('diffview').setup({
    -- 		view = {
    -- 			merge_tool = {
    -- 				disable_diagnostics = true
    -- 			},
    -- 		},
    -- 		hooks = {
    -- 			view_opened = function()
    -- 				-- Change local options in diff buffers
    -- 				vim.opt_local.wrap = true
    -- 				vim.lsp.stop_client(vim.lsp.get_active_clients())
    -- 			end
    -- 			-- view_closed = function(view)
    -- 			-- end,
    -- 		}
    --
    --
    -- 	})
    -- end
  },

  { 'mbbill/undotree' },

  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        separator = '',
      }
      require('nvim-treesitter.install').compilers = { 'gcc-14' }
    end,
  },
  { 'nvim-telescope/telescope-file-browser.nvim' },
  'dstein64/vim-startuptime',
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    config = function()
      require('no-neck-pain').setup {
        width = 175,
        -- autocmds = {
        -- 	-- When `true`, enables the plugin when you start Neovim.
        -- 	-- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
        -- 	-- The command is cleaned once it has successfuly ran once.
        -- 	--- @type boolean
        -- 	enableOnVimEnter = true,
        -- 	-- When `true`, enables the plugin when you enter a new Tab.
        -- 	-- note: it does not trigger if you come back to an existing tab, to prevent unwanted interfer with user's decisions.
        -- 	--- @type boolean
        -- 	enableOnTabEnter = true,
        -- },
      }
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      require('notify').setup {
        background_colour = '#000000',
        stages = 'static',
      }
    end,
  },
  {

    'folke/noice.nvim',
    dependencies = {},
    config = function()
      require('noice').setup {
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
      }
    end,
  },

  -- 'wakatime/vim-wakatime',
  -- 'mattn/emmet-vim',
  -- {
  --   'elixir-tools/elixir-tools.nvim',
  --   -- version = "*",
  --   branch = 'main',
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   -- event = { "VeryLazy" },
  --   config = function()
  --     local elixir = require 'elixir'
  --     local elixirls = require 'elixir.elixirls'
  --
  --     local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
  --
  --     elixir.setup {
  --       nextls = {
  --         enable = true,
  --         on_attach = function(client, bufnr)
  --           local helpers = require 'custom.helpers'
  --           helpers.on_attach(client, bufnr)
  --         end,
  --       },
  --       credo = {},
  --       elixirls = {
  --         enable = true,
  --         settings = elixirls.settings {
  --           dialyzerEnabled = false,
  --           enableTestLenses = false,
  --         },
  --         on_attach = function(client, bufnr)
  --           local helpers = require 'custom.helpers'
  --           helpers.on_attach(client, bufnr)
  --
  --           vim.keymap.set('n', '<space>fp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
  --           vim.keymap.set('n', '<space>tp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
  --           vim.keymap.set('v', '<space>em', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
  --         end,
  --         handlers = {
  --           ['textDocument/publishDiagnostics'] = function() end,
  --         },
  --         projectionist = { enable = true },
  --       },
  --     }
  --   end,
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  -- },
  {
    'max397574/better-escape.nvim',
    config = function()
      -- lua, default settings
      require('better_escape').setup {
        timeout = vim.o.timeoutlen, -- after `timeout` passes, you can press the escape key and the plugin will ignore it
        default_mappings = true, -- setting this to false removes all the default mappings
        mappings = {
          -- i for insert
          i = {
            j = {
              -- These can all also be functions
              k = '<Esc>',
              j = '<Esc>',
            },

            k = {
              -- These can all also be functions
              k = '<Esc>',
              j = '<Esc>',
            },
          },
          -- c = {
          --   j = {
          --     k = '<C-c>',
          --     j = '<C-c>',
          --   },
          -- },
          -- t = {
          --   j = {
          --     k = '<C-\\><C-n>',
          --   },
          -- },
          -- v = {
          --   j = {
          --     k = '<Esc>',
          --   },
          -- },
          -- s = {
          --   j = {
          --     k = '<Esc>',
          --   },
          -- },
        },
      }
    end,
  },
  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  --   config = true,
  -- },
  -- {
  --   'nvim-neorg/neorg',
  --
  --   config = function()
  --     require('neorg').setup {
  --       load = {
  --         ['core.defaults'] = {}, -- Loads default behaviour
  --         ['core.journal'] = {
  --           config = {
  --             strategy = 'flat',
  --           },
  --         },
  --         ['core.concealer'] = {
  --           config = {
  --             icon_preset = 'diamond',
  --           },
  --         }, -- Adds pretty icons to your documents
  --         ['core.keybinds'] = {
  --           config = {
  --             engine = 'nvim-cmp',
  --           },
  --         },
  --
  --         ['core.completion'] = {
  --           config = {
  --             engine = 'nvim-cmp',
  --             default_keybinds = true,
  --             neorg_leader = '<Leader>',
  --           },
  --         },
  --         ['core.dirman'] = { -- Manages Neorg workspaces
  --           config = {
  --             workspaces = {
  --               notes = '~/notes',
  --             },
  --             default_workspace = 'notes',
  --           },
  --         },
  --         ['core.summary'] = {
  --           config = {
  --
  --             strategy = 'default',
  --           },
  --         },
  --         ['external.templates'] = {
  --           -- templates_dir = vim.fn.stdpath("config") .. "/templates/norg",
  --           -- default_subcommand = "add", -- or "fload", "load"
  --           -- keywords = { -- Add your own keywords.
  --           --   EXAMPLE_KEYWORD = function ()
  --           --     return require("luasnip").insert_node(1, "default text blah blah")
  --           --   end,
  --           -- },
  --           -- snippets_overwrite = {},
  --         },
  --       },
  --     }
  --   end,
  --
  --   dependencies = { 'luarocks.nvim', { 'pysan3/neorg-templates', dependencies = { 'L3MON4D3/LuaSnip' } } },
  --
  --   -- put any other flags you wanted to pass to lazy here!
  --   --
  -- },
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = {
      -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
      -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
      'BufReadPre /Users/mg/Library/Mobile Documents/iCloud~com~logseq~logseq/Documents/pages/**.md',
      'BufNewFile /Users/mg/Library/Mobile Documents/iCloud~com~logseq~logseq/Documents/pages/**.md',
    },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'personal',
          path = '/Users/mg/Library/Mobile Documents/iCloud~com~logseq~logseq/Documents/pages',
        },
      },

      -- see below for full list of options 👇
    },
  },
  -- {
  -- 	"jackMort/ChatGPT.nvim",
  -- 	event = "VeryLazy",
  -- 	config = function()
  -- 		require("chatgpt").setup({
  -- 			openai_params = {
  -- 				model = "gpt-4",
  -- 				frequency_penalty = 0,
  -- 				presence_penalty = 0,
  -- 				max_tokens = 300,
  -- 				temperature = 0,
  -- 				top_p = 1,
  -- 				n = 1,
  -- 			},
  -- 		})
  -- 	end,
  -- 	dependencies = {
  -- 		"MunifTanjim/nui.nvim",
  -- 		"nvim-lua/plenary.nvim",
  -- 		"nvim-telescope/telescope.nvim"
  -- 	},
  -- },
  -- {
  -- 	"zbirenbaum/copilot.lua",
  -- 	cmd = "Copilot",
  -- 	event = "InsertEnter",
  -- 	config = function()
  -- 		require('copilot').setup({
  -- 			panel = {
  -- 				enabled = true,
  -- 				auto_refresh = false,
  -- 				keymap = {
  -- 					jump_prev = "cp",
  -- 					jump_next = "cn",
  -- 					accept = "<C-E>l",
  -- 					refresh = "gr",
  -- 					open = "<M-CR>"
  -- 				},
  -- 				layout = {
  -- 					position = "bottom", -- | top | left | right
  -- 					ratio = 0.4
  -- 				},
  -- 			},
  -- 			suggestion = {
  -- 				enabled = true,
  -- 				auto_trigger = false,
  -- 				debounce = 75,
  -- 				keymap = {
  -- 					accept = "<C-E>l",
  -- 					accept_word = false,
  -- 					accept_line = false,
  -- 					next = "<C-E>j",
  -- 					prev = "<C-E>k",
  -- 					dismiss = "<C-]>",
  -- 				},
  -- 			},
  -- 			filetypes = {
  -- 				yaml = false,
  -- 				markdown = false,
  -- 				help = false,
  -- 				gitcommit = false,
  -- 				gitrebase = false,
  -- 				hgcommit = false,
  -- 				svn = false,
  -- 				cvs = false,
  -- 				["."] = false,
  -- 			},
  -- 			copilot_node_command = 'node', -- Node.js version must be > 18.x
  -- 			server_opts_overrides = {},
  -- 		})
  -- 	end
  -- },
  -- {
  --   'LintaoAmons/scratch.nvim',
  --   event = 'VeryLazy',
  -- },

  -- {
  --   'maan2003/lsp_lines.nvim',
  --   config = function()
  --     require('lsp_lines').setup()
  --   end,
  -- },
  -- {
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  -- },
  -- { 'habamax/vim-godot', event = 'VimEnter' },
  -- 'tpope/vim-fugitive',
  {
    'lervag/vimtex',
    lazy = false,
    -- tag = "v2.15", -- uncomment to pin to a specific release
    config = function()
      --global vimtex settings
      vim.g.vimtex_imaps_enabled = 0 --i.e., disable them
      --vimtex_view_settings
      vim.g.vimtex_view_method = 'general' -- change this, depending on what you want to use..sumatraPDF, or skim, or zathura, or...
      vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
      --quickfix settings
      vim.g.vimtex_quickfix_open_on_warning = 0 --  don't open quickfix if there are only warnings
      vim.g.vimtex_quickfix_ignore_filters =
        { 'Underfull', 'Overfull', 'LaTeX Warning: .\\+ float specifier changed to', 'Package hyperref Warning: Token not allowed in a PDF string' }
    end,
  },
  {
    'GustavEikaas/easy-dotnet.nvim',
    -- 'nvim-telescope/telescope.nvim' or 'ibhagwan/fzf-lua' or 'folke/snacks.nvim'
    -- are highly recommended for a better experience
    dependencies = { 'nvim-lua/plenary.nvim', 'mfussenegger/nvim-dap', 'nvim-telescope/telescope.nvim' },
    config = function()
      local dotnet = require 'easy-dotnet'
      -- Options are not required
      dotnet.setup {
        managed_terminal = {
          auto_hide = true, -- auto hides terminal if exit code is 0
          auto_hide_delay = 1000, -- delay before auto hiding, 0 = instant
        },
        -- Optional configuration for external terminals (matches nvim-dap structure)
        external_terminal = nil,
        lsp = {
          enabled = false, -- Enable builtin roslyn lsp
          preload_roslyn = true, -- Start loading roslyn before any buffer is opened
          roslynator_enabled = true, -- Automatically enable roslynator analyzer
          easy_dotnet_analyzer_enabled = true, -- Enable roslyn analyzer from easy-dotnet-server
          auto_refresh_codelens = true,
          analyzer_assemblies = {}, -- Any additional roslyn analyzers you might use like SonarAnalyzer.CSharp
          config = {},
        },
        debugger = {
          -- Path to custom coreclr DAP adapter
          -- easy-dotnet-server falls back to its own netcoredbg binary if bin_path is nil
          bin_path = nil,
          console = 'integratedTerminal', -- Controls where the target app runs: "integratedTerminal" (Neovim buffer) or "externalTerminal" (OS window)
          apply_value_converters = true,
          auto_register_dap = true,
          mappings = {
            open_variable_viewer = { lhs = 'T', desc = 'open variable viewer' },
          },
        },
        ---@type TestRunnerOptions
        test_runner = {
          auto_start_testrunner = true,
          hide_legend = false,
          ---@type "split" | "vsplit" | "float" | "buf"
          viewmode = 'float',
          ---@type number|nil
          vsplit_width = nil,
          ---@type string|nil "topleft" | "topright"
          vsplit_pos = nil,
          icons = {
            passed = '',
            skipped = '',
            failed = '',
            success = '',
            reload = '',
            test = '',
            sln = '󰘐',
            project = '󰘐',
            dir = '',
            package = '',
            class = '',
            build_failed = '󰒡',
          },
          mappings = {
            run_test_from_buffer = { lhs = '<leader>r', desc = 'run test from buffer' },
            get_build_errors = { lhs = '<leader>e', desc = 'get build errors' },
            peek_stack_trace_from_buffer = { lhs = '<leader>p', desc = 'peek stack trace from buffer' },
            debug_test_from_buffer = { lhs = '<leader>d', desc = 'run test from buffer' },
            debug_test = { lhs = '<leader>d', desc = 'debug test' },
            go_to_file = { lhs = 'g', desc = 'go to file' },
            run_all = { lhs = '<leader>R', desc = 'run all tests' },
            run = { lhs = '<leader>r', desc = 'run test' },
            peek_stacktrace = { lhs = '<leader>p', desc = 'peek stacktrace of failed test' },
            expand = { lhs = 'o', desc = 'expand' },
            expand_node = { lhs = 'E', desc = 'expand node' },
            collapse_all = { lhs = 'W', desc = 'collapse all' },
            close = { lhs = 'q', desc = 'close testrunner' },
            refresh_testrunner = { lhs = '<C-r>', desc = 'refresh testrunner' },
            cancel = { lhs = '<C-c>', desc = 'cancel in-flight operation' },
          },
        },
        new = {
          project = {
            prefix = 'sln', -- "sln" | "none"
          },
        },
        csproj_mappings = true,
        fsproj_mappings = true,
        auto_bootstrap_namespace = {
          --block_scoped, file_scoped
          type = 'block_scoped',
          enabled = true,
          use_clipboard_json = {
            behavior = 'prompt', --'auto' | 'prompt' | 'never',
            register = '+', -- which register to check
          },
        },
        server = {
          ---@type nil | "Off" | "Critical" | "Error" | "Warning" | "Information" | "Verbose" | "All"
          log_level = nil,
        },
        -- choose which picker to use with the plugin
        -- possible values are "telescope" | "fzf" | "snacks" | "basic"
        -- if no picker is specified, the plugin will determine
        -- the available one automatically with this priority:
        -- telescope -> fzf -> snacks ->  basic
        picker = 'telescope',
        background_scanning = true,
        notifications = {
          --Set this to false if you have configured lualine to avoid double logging
          handler = function(start_event)
            local spinner = require('easy-dotnet.ui-modules.spinner').new()
            spinner:start_spinner(start_event.job.name)
            ---@param finished_event JobEvent
            return function(finished_event) spinner:stop_spinner(finished_event.result.msg, finished_event.result.level) end
          end,
        },
        diagnostics = {
          default_severity = 'error',
          setqflist = false,
        },
      }

      -- Example command
      vim.api.nvim_create_user_command('Secrets', function() dotnet.secrets() end, {})

      -- Example keybinding
      vim.keymap.set('n', '<C-p>', function() dotnet.run_project() end)
    end,
  },
  {
    'seblyng/roslyn.nvim',
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
}
