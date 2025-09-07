{lib, pkgs, inputs, ...}: {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = {

        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ 
        #    "copilot.vim" 
        #];

        extraPlugins = with pkgs.vimPlugins; [ 
            gruvbox-material 
            #copilot-vim
        ];

        plugins = {
            #copilot-vim.enable = true;
        };

        colorscheme = "gruvbox-material";
        globals = {
            gruvbox_material_background = "hard";
            gruvbox_material_foreground = "material";
            background = "dark";
        };

        opts = {
            number = true;
            relativenumber = false;
            shiftwidth = 2;
        };

    };
}