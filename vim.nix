{ pkgs, ... }:
let
  neovim' = pkgs.neovim.override {
    vimAlias = true;
    configure = {
      customRC = ''
        set nu
        set ignorecase
        set mouse=a

        set undodir=~/.cache/vim/
        set undofile
        set undolevels=100
        set undoreload=1000

        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
        set foldnestmax=0

        lua <<EOF
        lspconfig = require('lspconfig')
        lspconfig.bashls.setup {
          cmd = { "${pkgs.nodePackages.bash-language-server}/bin/bash-language-server", "start" },
        }
        lspconfig.pyright.setup {
          cmd = { "${pkgs.nodePackages.pyright}/bin/pyright-langserver", "--stdio" },
        }
        lspconfig.rnix.setup {
          cmd = { "${pkgs.rnix-lsp}/bin/rnix-lsp" },
        }
        lspconfig.yamlls.setup {
          cmd = { "${pkgs.yaml-language-server}/bin/yaml-language-server", "--stdio" },
        }
        EOF

        lua <<EOF
        require'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
            disable = {},
          },
          indent = {
            enable = true,
            disable = {},
          },
        }

        vim.api.nvim_command("autocmd BufNewFile,BufRead *.nix setlocal filetype=nix")
        EOF
      '';
      packages.myPlugins = with pkgs.vimPlugins; {
        start = [
          editorconfig-vim
          lightline-vim
          vim-trailing-whitespace
          vim-unimpaired

          neoformat

          vim-nix

          completion-nvim
          nvim-lspconfig
          (nvim-treesitter.withPlugins (p: pkgs.tree-sitter.allGrammars))
        ];
      };
    };
  };
in {
  environment.systemPackages = with pkgs; [
    neovim'
  ];

  programs.vim.defaultEditor = true;
}
