{
  pkgs,
  lib,
  ...
}: {
  config = {
    globals = {
      UltiSnipsExpandTrigger = "<tab>";
      UltiSnipsJumpForwardTrigger = "<tab>";
      UltiSnipsJumpBackwardTrigger = "<tab>";
      UltiSnipsSnippetDirectories = ["${./UltiSnips}"];
    };

    extraPlugins = [
      pkgs.vimPlugins.ultisnips
    ];
  };
}
