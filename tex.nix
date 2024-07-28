{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.vimtex;
in {
  options = {
    vimtex.enable = lib.mkEnableOption "Enable vimtex (installs tex distribution)";
  };

  config = lib.mkIf cfg.enable {
    globals = {
      tex_flavor = "latex";
      tex_conceal = "abdmg";
    };

    opts = {
      conceallevel = 1;
    };

    plugins.vimtex = {
      enable = true;
      texlivePackage = pkgs.texlive.combined.scheme-full;
      settings = {
        view_method = "skim";
        compiler_method = "latexmk";
        quickfix_enabled = true;
        quickfix_open_on_warning = false;

        quickfix_ignore_filters = [
          "Underfull"
          "Overfull"
          "specifier changed to"
          "Token not allowed in a PDF string"
        ];
      };
    };

    plugins.treesitter = {
      settings = {
        highlight.disable = ["latex"];
      };
    };
  };
}
