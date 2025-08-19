{pkgs, inputs, ...}: {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = {

        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;

        extraPlugins = with pkgs.vimPlugins; [ 
            gruvbox-material 
        ];

        colorscheme = "gruvbox-material";
        globals = {
            gruvbox_material_background = "hard";
            gruvbox_material_foreground = "material";
            background = "dark";
        };


        opts = {
            number = true;
            relativenumber = true;
            shiftwidth = 2;
        };

    };
}