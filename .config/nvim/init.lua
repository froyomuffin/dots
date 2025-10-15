-- Load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with plugins
require("lazy").setup({
  -- Themes
  "EdenEast/nightfox.nvim",
  
  -- Terminal
  { "akinsho/toggleterm.nvim", version = "*" },
  
  -- Git integration
  "airblade/vim-gitgutter",
  
  -- Status line
  "bling/vim-airline",
  
  -- Colorizer
  "chrisbra/colorizer",
  
  -- Auto read
  "djoshea/vim-autoread",
  
  -- FZF
  -- { "junegunn/fzf", build = "./install --bin" },
  -- "junegunn/fzf.vim",
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {}
  },
  
  -- Movement
  "matze/vim-move",
  
  -- Tabline
  "nanozuki/tabby.nvim",
  
  -- LSP
  "neovim/nvim-lspconfig",
  
  -- Devicons
  "nvim-tree/nvim-web-devicons",
  
  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  "nvimdev/indentmini.nvim",
  
  -- LSP fuzzy
  "ojroques/nvim-lspfuzzy",
  
  -- Goto preview
  "rmagatti/goto-preview",
  
  -- Multiple cursors
  "terryma/vim-multiple-cursors",
  
  -- Commentary
  "tpope/vim-commentary",
  
  -- Endwise
  "tpope/vim-endwise",
  
  -- Fugitive
  "tpope/vim-fugitive",
  
  -- Rhubarb
  "tpope/vim-rhubarb",

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      display = {
        chat = {
          intro_message = "",
          separator = "─", -- The separator between the different messages in the chat buffer
          show_context = true, -- Show context (from slash commands and variables) in the chat buffer?
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          show_settings = false, -- Show LLM settings at the top of the chat buffer?
          show_token_count = true, -- Show the token count for each response?
          show_tools_processing = true, -- Show the loading message when tools are being executed?
          start_in_insert_mode = false, -- Open the chat buffer in insert mode?
          layout = "horizontal", -- vertical|horizontal|buffer
        },
        inline = {
          layout = "horizontal", -- vertical|horizontal|buffer
        },
      },
      adapters = {
        http = {
          provider = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                -- or "http://thena:8000/api/v1",
                url = "http://" .. os.getenv("CODE_COMPANION_API_URL") .. "/api/v1", 
                chat_url = "/chat/completions",
                models_endpoint = "/models",
              },
              schema = {
                model = {
                  default = "Qwen3-Coder-30B-A3B-Instruct-GGUF",
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "provider",
        },
        inline = {
          adapter = "provider",
        },
        cmd = {
          adapter = "provider",
        },
      },
    },
  }
})

-- Backup directory
vim.opt.backupdir = vim.fn.expand('~') .. '/backup//'

-- Apply theme
vim.cmd('colorscheme nightfox')

-- Vim General Settings
vim.cmd.filetype("plugin indent on")
vim.keymap.set('n', '<C-c><C-c>', ':q<CR>')
vim.opt.backspace = '2'
vim.opt.cursorline = true
vim.opt.directory = vim.fn.expand('~') .. '/swap//'
vim.opt.expandtab = true
vim.opt.fillchars = 'vert:\\'
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.modifiable = true
vim.opt.mouse = 'a'
vim.opt.swapfile = false
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.timeoutlen = 400
vim.cmd.syntax("on")

-- Allow ; alone to speed up :
vim.keymap.set('n', ';', ':')

-- Leader setup
vim.opt.showcmd = true
vim.g.mapleader = '\\'
vim.keymap.set('n', "'", '<leader>')

-- Character limit bar
vim.opt.colorcolumn = "120"

-- Bind reloading config
vim.keymap.set('n', '<leader>e', ':e %<CR>')
-- vim.keymap.set('n', '<leader>l', ':Lazy reload<CR>')

-- Persistent undo
if vim.fn.has('persistent_undo') == 1 then
  vim.opt.undofile = true
  vim.opt.undodir = vim.fn.expand('~') .. '/undo//'
end

-- vim-airline
vim.opt.laststatus = 2
vim.g.airline_left_sep = ''
vim.g.airline_right_sep = ''
vim.g.airline_section_b = ''

-- Splits
vim.g.fzf_action = {
  ['ctrl-s'] = 'split',
  ['ctrl-v'] = 'vsplit',
  ['ctrl-t'] = 'tabedit',
  ['ctrl-x'] = 'bd'
}
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.api.nvim_set_hl(0, "VertSplit", { ctermbg = "none", bg = "none" })
vim.opt.fillchars = 'vert:│'

-- Clipboard
vim.opt.clipboard = 'unnamedplus'

-- Copy to Clipboard
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+yg_')
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>yy', '"+yy')

-- Paste from Clipboard
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>P', '"+P')

-- Fast up and down
vim.keymap.set('', '<S-Up>', '5k')
vim.keymap.set('', '<S-Down>', '5j')

-- Set Theme
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = true,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    colorblind = {
      enable = true,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
    styles = {               -- Style to be applied to different syntax groups
      comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "NONE",
      functions = "NONE",
      keywords = "NONE",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- Split matching combo
vim.keymap.set("n", "<C-v>", "<C-w>L<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-b>", "<C-w>J<CR>", { noremap = true, silent = true })

-- Language servers
-- require'lspconfig'.pyright.setup{}
-- require'lspconfig'.rubocop.setup{}
-- require'lspconfig'.ruby_lsp.setup{}
-- require'lspconfig'.sorbet.setup{
  -- cmd = { "srb", "tc", "--lsp", "--disable-watchman" }
-- }

-- Language servers
vim.lsp.config('pyright', {})
vim.lsp.enable({"pyright"})

vim.lsp.config('rubocop', {})
vim.lsp.enable({"rubocop"})

vim.lsp.config('ruby_lsp', {})
vim.lsp.enable({"ruby_lsp"})

vim.lsp.config('sorbet', {
  cmd = { "srb", "tc", "--lsp", "--disable-watchman" }
})
vim.lsp.enable({"sorbet"})

vim.api.nvim_command("au BufRead,BufNewFile *.rbi setfiletype ruby")

-- Highlighting
require'nvim-treesitter.configs'.setup{
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "javascript", "yaml", "ruby", "json", "liquid", "typescript"},
  highlight = {
    enable = true
  }
}

-- Vim highlights
vim.api.nvim_set_hl(0, "SpellBad", { ctermfg = 0 })
vim.api.nvim_set_hl(0, "Search", { ctermfg = 0 })

-- Buffer management
vim.keymap.set('n', '<leader>b', ':Buffers<CR>')

-- Commenting
vim.keymap.set('n', '<leader>c', ':Commentary<CR>')

-- Open git line in browser
vim.keymap.set('n', '<leader>g', ':GBrowse<CR>')

-- Colorizing hexcodes
vim.g.colorizer_auto_filetype = 'css,html,conf'

-- Unhighlight
vim.keymap.set('n', '<leader>n', ':noh<CR>')

-- Completion
vim.keymap.set('i', '<Tab>', '<C-x><C-]>')
vim.keymap.set('i', '<Tab><Tab>', '<C-x><C-p>')

--vim.keymap.set("n", "gr", vim.lsp.buf.incoming_calls, { noremap = true, silent = true })
vim.keymap.set("n", "gi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "GI", vim.lsp.buf.implementation, { noremap = true, silent = true })

vim.keymap.set("n", "gd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "GD", vim.lsp.buf.definition, { noremap = true, silent = true })

vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, silent = true })

-- Preview Popup
require('goto-preview').setup {
  width = 120,
  height = 20,
}

-- LSP and fzf
require('lspfuzzy').setup {}

-- Terminal
vim.api.nvim_set_keymap("n", "<leader>x", ":ToggleTerm<CR>", { noremap = true })

require("toggleterm").setup {
  open_mapping = [[<c-x>]],
}

-- Tabs
vim.o.showtabline = 2

vim.api.nvim_set_keymap("n", "<C-t>", ":$tabnew<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>r", ":Tabby rename_tab ", { noremap = true })

local theme = {
  fill = 'TabLineFill',
  head = 'TabLine',
  current_tab = 'TabLineSel',
  tab = 'TabLine',
  win = 'TabLine',
  tail = 'TabLine',
}

require('tabby').setup({
  line = function(line)
    return {
      {
        line.sep(' ', theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep(' ', hl, theme.fill),
          tab.number(),
          tab.name(),
          line.sep(' ', hl, theme.fill),
          hl = hl,
          margin = ' ',
        }
      end),
      line.spacer(),
      line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
        return {
          line.sep(' ', theme.win, theme.fill),
          win.is_current() and '' or '',
          win.buf_name(),
          line.sep(' ', theme.win, theme.fill),
          hl = theme.win,
          margin = ' ',
        }
      end),
      hl = theme.fill,
    }
  end,
  -- option = {}, -- setup modules' option,
})

-- Search
require('fzf-lua').setup({
  grep = {
    exe = 'rg',
    rg_opts = '-L --color=never --no-heading --with-filename --line-number --column --smart-case --no-ignore-vcs',
  },
  files = {
    cmd = 'rg -L --files --no-ignore-vcs --hidden -g "!.git"',
  },
  -- Enable ripgrep for all grep operations
  actions = {
    ['default'] = function(selected)
      require('fzf-lua').action('default', selected)
    end,
  },
})

---- Bind Search
vim.keymap.set('n', '<leader>/', ':FzfLua grep<CR>')

-- Bind Search under cursor
vim.keymap.set('n', '<leader>//', ':FzfLua grep_cword<CR>')

-- Bind FileSearch
vim.keymap.set('', '<C-p>', ':FzfLua files<CR>')
vim.keymap.set('n', '<leader>p', ':FzfLua files<CR>')

-- Bind codecompanion
vim.keymap.set({'n', 'v'}, '<leader>l', '<cmd>CodeCompanion<CR>')
vim.keymap.set({'n', 'v'}, '<leader>o', '<cmd>CodeCompanion<CR>')
vim.keymap.set({'n', 'v'}, '<leader>]', '<cmd>CodeCompanion<CR>')
vim.keymap.set({'n', 'v'}, '<leader>[', '<cmd>CodeCompanionChat Toggle<CR>')
vim.keymap.set({'n', 'v'}, '<leader>i', '<cmd>CodeCompanionChat Toggle<CR>')
vim.keymap.set({'n', 'v'}, '<leader><leader><leader>', '<cmd>CodeCompanionChat Toggle<CR>')

-- Indents
require("indentmini").setup()
vim.cmd.highlight('IndentLine guifg=#373B41')
vim.cmd.highlight('IndentLineCurrent guifg=#F0C674')

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#373B41' })
