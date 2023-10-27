{ inputs, lib, config, pkgs, ... }: 
{
  programs = { # configuring programs
    nixvim = {
      enable = true;

      colorschemes.catppuccin = {
        enable = true;
        
        flavour = "mocha";

        terminalColors = true;
      };

      plugins = {
        nix = {
          enable = true;
        };

        lsp = {
          enable = true;

          servers = {
            nil_ls = {
              enable = true;
            };

            clangd = {
              enable = true;
            };

            cmake = {
              # sometimes fails to install
              # enable = true;
            };

            java-language-server = { 
              enable = true;
            };

            rust-analyzer = {
              enable = true;
            };
          };
        };

        treesitter = {
          enable = true;
        };

        dap = { 
          enable = true;

          extensions = { 
            dap-ui ={
              enable = true;
            };
          };
        };

        rust-tools = {
          enable = true;
        };

        coq-nvim = {
          enable = true;
        };
      };
    };
  };
}
