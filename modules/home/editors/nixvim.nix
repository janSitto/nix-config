{
  inputs,
  lib,
  pkgs,
  ...
}:
{

  # NOTE TO SELF
  /*
    To go back to using this add this flake input:

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    and add "nixvim" to the outputs

    ...then add "../modules/home/editors/nixvim.nix" to home-config.nix imports
  */
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
