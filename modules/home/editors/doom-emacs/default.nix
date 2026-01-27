{ inputs, pkgs, ... }:
{
  imports = [ inputs.doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    emacs = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      #treesit-grammars.with-all-grammars
      pkgs.emacs.pkgs.lsp-bridge
    ];
    doomDir = ./doom.d;
    #tangleArgs = "--all config.org";
    #experimentalFetchTree = true;

  };

}
