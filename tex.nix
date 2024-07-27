{
  pkgs,
  lib,
  ...
}: {
  config = {
    globals = {
      tex_flavor = "latex";
      tex_conceal = "abdmg";
    };

    opts = {
      conceallevel = 1;
    };

    plugins.vimtex = {
      enable = true;
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
