{
  description = "Harry Neovim Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-parts,
    ...
  } @ inputs: let
    config = import ./config.nix;
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem = {
        pkgs,
        system,
        ...
      }: let
        # override nixpkgs to allow unfree copilot
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg:
            builtins.elem (pkgs.lib.getName pkg) [
              "copilot.vim"
            ];
        };

        nixvimLib = nixvim.lib.${system};
        mkNix = nixvim.legacyPackages.${system}.makeNixvimWithModule;
        nvim = mkNix {
          inherit pkgs;
          module = config {
            inherit pkgs;
            vimtex = false;
            copilot = false;
          };
        };
        nvim-tex = mkNix {
          inherit pkgs;
          module = config {
            inherit pkgs;
            vimtex = true;
            copilot = false;
          };
        };
        nvim-ai = mkNix {
          inherit pkgs;
          module = config {
            inherit pkgs;
            vimtex = false;
            copilot = true;
          };
        };
        nvim-tex-ai = mkNix {
          inherit pkgs;
          module = config {
            inherit pkgs;
            vimtex = true;
            copilot = true;
          };
        };
      in {
        checks = {
          default = nixvimLib.check.mkTestDerivationFromNvim {
            inherit nvim;
            name = "A nixvim configuration";
          };
        };

        packages = {
          default = nvim;
          nvim = nvim;
          nvimWithTex = nvim-tex;
          nvim-tex = nvim-tex;
          nvim-ai = nvim-ai;
          nvim-tex-ai = nvim-tex-ai;
        };

        devShells.default = pkgs.mkShellNoCC {
          packages = [
            nvim
          ];
        };
      };
    };
}
