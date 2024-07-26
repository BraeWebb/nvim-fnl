{
  pkgs,
  lib,
  ...
}: {
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = ";";
    };

    opts = {
      number = true;
      mouse = "a";
      showmode = false;
      clipboard = "unnamedplus";
      breakindent = true;
      updatetime = 250;
      timeoutlen = 300;
      cursorline = true;
      scrolloff = 10;
      ignorecase = true;
      smartcase = true;
      hlsearch = true;
      inccommand = "split";
      signcolumn = "yes";
      conceallevel = 0;
      foldenable = false;
      hidden = true;
      swapfile = false;
      backup = false;
      undofile = true;
      termguicolors = true;

      splitright = true;
      splitbelow = true;
      wrap = false;
      pumblend = 10;
      pumheight = 10;
      confirm = true;

      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;
      list = true;
      listchars = "tab:» ,trail:·,nbsp:␣";
    };

    colorschemes = {
      rose-pine = {
        enable = true;
      };
    };

    plugins = {
      nvim-autopairs.enable = true;
      cmp = {
        enable = true;
        settings = {
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "buffer";}
          ];
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item";
            "<C-p>" = "cmp.mapping.select_previous_item";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete";
            "<C-e>" = "cmp.mapping.abort";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
        };
      };
      cmp-nvim-lsp = {enable = true;};
      #cmp-buffer = {enable = true;};
      cmp-path = {enable = true;};
      cmp_luasnip = {enable = true;};

      comment.enable = true;
      conform-nvim = {
        enable = true;
        notifyOnError = true;
        formattersByFt = {
          lua = ["stylua"];
          fennel = ["fnlfmt"];
          python = ["ruff_format"];
          javascript = [["prettierd" "prettier" "eslint_d"]];
          typescriptreact = [["prettierd" "eslint_id"]];
          gdscript = ["gdformat"];
          nix = ["alejandra"];
        };

        formatOnSave = {
          lspFallback = true;
          timeoutMs = 500;
        };
        #mapping = {
        #  "<leader>f" = "conform.format({ async = true, lsp_fallback = true })";
        #};
      };

      gitsigns.enable = true;

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
        };
      };

      neo-tree = {
        enable = true;
        window.mappings = {
          "l" = "open";
          "h" = "close_node";
          "P" = {
            command = "toggle_preview";
            config = {use_float = true;};
          };
        };
      };

      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          ui-select.enable = true;
        };
        settings = {
          defaults = {
            file_ignore_patterns = ["node_modules"];
            # TODO: vimgrep_arguments = []
          };
        };
        keymaps = {
          "<localleader>f" = {
            action = "find_files";
            options.desc = "Search for files in the current directory";
          };
          "<localleader>g" = {
            action = "live_grep";
            options.desc = "RE search for matches in the current directory";
          };
        };
      };

      todo-comments = {
        enable = true;
        signs = false;
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;

          ensure_installed = [
            "nix"
            "bash"
            "fish"
            "vim"
            "vimdoc"
            "clojure"
            "commonlisp"
            "dockerfile"
            "fennel"
            "html"
            "java"
            "javascript"
            "typescript"
            "tsx"
            "astro"
            "json"
            "lua"
            "markdown"
            "yaml"
            "python"
          ];
        };
      };
    };

    extraConfigLuaPre = ''
      -- Formatting function for conform
      _G.format_with_conform = function()
        local conform = require("conform")
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 2000,
        })
      end
      _G.toggle_neotree = function()
        local neotree = require("neo-tree.command");
        neotree.execute({
          toggle = true,
          dir = vim.uv.cwd()
        })
      end
    '';

    keymaps = [
      {
        key = "<leader>f";
        mode = ["n" "v"];
        action = ":lua _G.format_with_conform()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "[F]ormat buffer";
        };
      }
      {
        key = "<leader>e";
        mode = ["n" "v"];
        action = ":lua _G.toggle_neotree()<CR>";
        options = {
          silent = true;
          noremap = true;
          desc = "[e]xplore files";
        };
      }
    ];

    extraPackages = [
      pkgs.alejandra
    ];
  };
}
