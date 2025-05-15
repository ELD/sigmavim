return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    auto_attach = true, -- automatically attach to buffers
    prefix = "::", -- default prefix to use for Avante commands
    show_command_history = true, -- show command history on the right side
    copilot = {
      model = "claude-3.7-sonnet", -- using Claude for better reasoning
      timeout = 45000, -- Increased timeout for complex requests
      temperature = 0, -- 0 for deterministic responses
      max_completion_tokens = 102400, -- Increased token limit
      reasoning_effort = "high", -- Set to "high" for better reasoning capabilities
      client_options = {
        debug = true, -- Enable debug mode for logging
      },
    },
    suggestion = {
      debounce = 600,
      throttle = 600,
    },
    behaviour = {
      auto_focus_sidebar = true,
      auto_suggestions = true, -- Experimental stage
      auto_suggestions_respect_ignore = true,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      jump_result_buffer_on_finish = false,
      support_paste_from_clipboard = true,
      minimize_diff = true,
      enable_token_counting = true,
      use_cwd_as_project_root = false,
      auto_focus_on_diff_view = false,
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional but recommended for AI-assisted coding
    -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      build = ":Copilot auth",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          copilot_model = "claude-3.7-sonnet", -- Using the same model as Avante for consistency
          panel = {
            enabled = false, -- Enable the suggestions panel for easy access
            auto_refresh = false,
            keymap = {
              jump_next = "<c-j>",
              jump_prev = "<c-k>",
              accept = "<c-y>",
              refresh = "r",
              open = "<M-CR>",
            },
            layout = {
              position = "bottom", -- Position at the bottom of the screen
              ratio = 0.4, -- Fixed typo from "ration" to "ratio"
            },
          },
          suggestion = {
            enabled = false, -- Enable inline suggestions
            auto_trigger = true, -- Automatically show suggestions
            debounce = 50, -- Reduced debounce for faster suggestions
            keymap = {
              accept = "<Tab>", -- Use Tab to accept suggestions
              accept_word = "<C-w>", -- Accept word with Ctrl+w
              accept_line = "<C-l>", -- Accept line with Ctrl+l
              next = "<c-j>",
              prev = "<c-k>",
              dismiss = "<C-x>", -- Changed to avoid conflict with accept
            },
          },
          filetypes = {
            -- Specify filetypes where Copilot should be active
            ["*"] = true, -- Enable for all filetypes
            -- Disable for specific filetypes if needed
            -- ["help"] = false,
          },
          server_opts_overrides = {
            advanced = {
              length = 8, -- Show more suggestions
              time_budget = 50, -- Increased time budget for better suggestions
              max_tokens = 2000, -- Increased max tokens for longer completions
              inlineSuggestCount = 3, -- Show more inline suggestions
            },
          },
        })
      end,
    }, -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
  },
}
