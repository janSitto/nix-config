{inputs, lib, pkgs, ...}: {
    /*

    Pretty useful documentation: https://nvf.notashelf.dev/

    */

    imports = [ inputs.nvf.homeManagerModules.default ];

    programs.nvf = {
        enable = true;

        settings.vim = {
            
            viAlias = true;
            vimAlias = true;

            filetree = {
                neo-tree = {
                    enable = true;
                    setupOpts = {
                        close_if_last_window = true;
                        enable_git_status = true;
                        enable_diagnostics = true;
                    };
                };
            };

            theme = {
                enable = true;
                name = "gruvbox";
                style = "dark";
            };

            statusline.lualine. enable = true;
            telescope.enable = true;
            autocomplete.nvim-cmp.enable = true;
    
            languages = {
                nix.enable = true;
                rust.enable = true;
            };

        };

    };

    home.sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
    };

}