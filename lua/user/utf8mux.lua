local TMUX = (os.getenv "TMUX" ~= nil)
local ZELLIJ = (os.getenv "ZELLIJ" ~= nil)
if not TMUX and not ZELLIJ then
  return {
    plugins = {},
    mappings = function(v) return v end,
    icons = function(v) return v end,
  }
end

local icons = {
  BufferClose = "✗",
  DapStopped = "",
  DefaultFile = "",
  Diagnostic = "",
  DiagnosticError = "",
  DiagnosticHint = "",
  DiagnosticInfo = "",
  Git = "",
  LSPLoading2 = "",
  Paste = "",
  Spellcheck = "",
  Search = "",
  TabClose = "",
}

local function get_icon(kind) return icons[kind] end
local button = require("astronvim.utils").alpha_button

return {
  -- Inside your user/plugins/utf8mux.lua:
  -- ```
  -- return require("user.utf8mux").icons`
  -- ```
  plugins = {
    {
      -- if you use your own buttons section comment out this table
      "alpha-nvim",
      optional = true,
      opts = {
        section = {
          buttons = {
            val = {
              button("LDR n", "  New File  "),
              button("LDR f f", get_icon "Search" .. "  Find File  "), -- does not follow icons table by default
              button("LDR f o", get_icon "DefaultFile" .. "  Recents  "), -- does not follow icons table by default
              button("LDR f w", "  Find Word  "),
              button("LDR f '", "  Bookmarks  "),
              button("LDR S l", "  Last Session  "),
            },
          },
        },
      },
    },
    {
      "lspkind.nvim",
      optional = true,
      opts = function(_, opts)
        if opts.preset ~= "codicons" then
          opts.symbol_map = {
            Array = "",
            Key = "",
            Namespace = "",
            Null = "",
            Object = "",
            Package = "",
            String = "",
            TypeParameter = "",
            Text = "",
            Method = "",
            Function = "",
            Field = "",
            Variable = "",
            Class = "",
            Value = "",
            Keyword = "",
            Color = "",
            File = get_icon "DefaultFile",
            Folder = "",
            Constant = "",
            Struct = "",
            Operator = "",
          }
        end
      end,
    },
    {
      "nvim-web-devicons",
      optional = true,
      opts = {
        override = {
          lock = {
            icon = "",
          },
          mp3 = {
            icon = "",
          },
          -- ["robots.txt"] = {
          -- icon = "󰚩"
          -- }, -- found no alternative
          cs = {
            icon = "",
          },
          csv = {
            icon = get_icon "DefaultFile",
          },
          doc = {
            icon = "",
          },
          docx = {
            icon = "",
          },
          -- f90 = {
          --   icon = "󱈚", -- found no alternative
          -- },
          material = {
            icon = "",
          },
          mint = {
            icon = "",
          },
          opus = {
            icon = "",
          },
          ppt = {
            icon = "",
          },
          ps1 = {
            icon = "",
          },
          psd1 = {
            icon = "",
          },
          psm1 = {
            icon = "",
          },
          r = {
            icon = "",
          },
          -- rproj = {
          --   icon = "󰗆", -- found no alternative
          -- },
          -- scm = {
          --   icon = "󰘧", -- found no alternative
          -- },
          sv = {
            icon = "",
          },
          svh = {
            icon = "",
          },
          svg = {
            icon = "",
          },
          -- tbc = {
          --   icon = "󰛓", -- found no alternative
          -- },
          -- tcl = {
          --   icon = "󰛓",
          -- },
          tex = {
            icon = "",
          },
          tscn = {
            icon = "",
          },
          txt = {
            icon = get_icon "DefaultFile",
          },
          v = {
            icon = "",
          },
          vh = {
            icon = "",
          },
          vhd = {
            icon = "",
          },
          vhdl = {
            icon = "",
          },
          webpack = {
            icon = "",
          },
          xls = {
            icon = "",
          },
          xlsx = {
            icon = "",
          },
          xml = {
            icon = "",
          },
          sol = {
            icon = "",
          },
          prisma = {
            icon = "",
          },
          -- log = {
          --   icon = "󰌱", -- found no good alternative
          -- },
        },
      },
    },
  },

  -- Inside your user/mappings.lua:
  -- ```
  -- return require("user.utf8mux").mappings {
  --   YOUR_MAPPINGS
  -- }
  -- ```
  mappings = function(user_mappings)
    for key, value in pairs {
      ["<leader>f"] = { desc = get_icon "Search" .. " Find" }, -- does not follow icons table by default
      ["<leader>p"] = { desc = " Packages" },
      ["<leader>b"] = { s = { desc = " Sort Buffers" }, desc = " Buffers" },
      ["<leader>g"] = { desc = get_icon "Git" .. " Git" }, -- does not follow icons table by default
      ["<leader>S"] = { desc = " Session" },
    } do
      user_mappings.n[key] = value
    end
    return user_mappings
  end,

  -- Inside your user/icons.lua:
  -- ```
  -- return require("user.utf8mux").icons {
  --   YOUR_ICONS
  -- }
  -- ```
  icons = function(user_icons)
    for key, value in pairs(icons) do
      user_icons[key] = value
    end
    return user_icons
  end,
}
