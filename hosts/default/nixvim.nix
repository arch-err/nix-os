{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options = {
    nixvim.enable =
      lib.mkEnableOption "enable nixvim";
  };
  imports = [
    inputs.nixvim.nixosModules.nixvim
  ];

  config =
    lib.mkIf config.nixvim.enable {
      programs.nixvim = {
        enable = true;

        colorschemes.nord = {
          enable = true;
          settings = {
            disable_background = true;
            enable_sidebar_background = true;
          };
        };

        clipboard.providers.wl-copy.enable = true;
        clipboard.register = "unnamedplus";
        globals.mapleader = " "; # Sets the leader key to comma

        options = {
          guicursor = "";
          #
          title = true;
          titlestring = "neovim";
          #
          nu = true;
          relativenumber = false;
          #
          tabstop = 4;
          softtabstop = 4;
          shiftwidth = 4;
          expandtab = true;
          #
          smartindent = true;
          #
          wrap = true;
          showcmd = false;
          #
          swapfile = false;
          backup = false;
          #undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir";
          undofile = true;
          hlsearch = false;
          incsearch = true;
          termguicolors = true;
          scrolloff = 8;
          signcolumn = "yes";
          # isfname:append("@-@");
          updatetime = 50;
          # colorcolumn = "80";
          #
          mouse = "a";
          completeopt = "menuone,noselect";
        };

        keymaps = [
          {
            mode = "n";
            key = "<C-'>";
            options.silent = true;
            action = ''
              "vyiw:%s/v/v/g<Left><Left>
            '';
          }
          {
            mode = "n";
            key = "<leader>z";
            options.silent = true;
            action = "zfip";
          }
          {
            mode = "n";
            key = "U";
            options.silent = true;
            action = "<C-r>";
          }
          {
            mode = "n";
            key = "<leader>r";
            options.silent = true;
            action = ":!vimrunner <C-r>% & disown<CR><CR>";
          }
          {
            mode = "n";
            key = "<leader>k";
            options.silent = true;
            action = ":bn
";
          }
          {
            mode = "n";
            key = "<leader>j";
            options.silent = true;
            action = ":bp
";
          }
          {
            mode = "n";
            key = "<leader>o";
            options.silent = true;
            action = ":Telescope find_files
";
          }
        ];
        autoCmd = [
          {
            event = "BufWinLeave";
            pattern = "*.*";
            command = "mkview";
          }
          {
            event = "BufWinEnter";
            pattern = "*.*";
            command = "silent! loadview";
          }
        ];

        plugins = {
          lualine.enable = true;
          bufferline.enable = true;
          auto-save.enable = true;
          commentary.enable = true;
          surround.enable = true;
          nvim-autopairs.enable = true;
          which-key.enable = true;
          noice.enable = true;
          rainbow-delimiters.enable = true;
          nvim-tree.enable = true;
          telescope = {
            enable = true;
            keymaps = {
              "<leader>f" = "find_files";
              "<leader>g" = "live_grep";
            };
          };
          oil.enable = true;
          treesitter.enable = true;
          luasnip.enable = true;
          emmet.enable = true;
          nvim-colorizer.enable = true;
          lsp = {
            enable = true;
            servers = {
              tsserver.enable = true;
              lua-ls.enable = true;
              bashls.enable = true;
              pylsp.enable = true;
              # pylyzer.enable = true;
              phpactor.enable = true;

              cssls.enable = true;
              jsonls.enable = true;

              helm-ls.enable = true;
              dockerls.enable = true;
              yamlls.enable = true;
              # rust-analyzer.enable = true;
            };
          };
          nvim-cmp = {
            enable = true;
            autoEnableSources = true;
            sources = [
              {name = "nvim_lsp";}
              {name = "path";}
              {name = "buffer";}
            ];
            mapping = {
              "<CR>" = "cmp.mapping.confirm({ select = true })";
                modes = ["i" "s"];
              };
            };
          };
        };
      };
    };
}
