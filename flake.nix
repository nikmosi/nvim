{
  description = "An example project.";

  inputs.pre-commit-hooks.url = "github:cachix/git-hooks.nix";

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    in
    {
      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            end-of-file-fixer.enable = true;
            check-added-large-files.enable = true;
            trim-trailing-whitespace.enable = true;
            check-yaml.enable = true;
            fix-byte-order-marker.enable = true;
            stylua.enable = true;
            convco.enable = true;
            trufflehog = {
              enable = true;
              stages = [ "pre-push" ];
            };
          };
        };
      });

      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = self.checks.${system}.pre-commit-check.enabledPackages ++ (with nixpkgs.legacyPackages.${system}; [
            ripgrep
            fd
            lua-language-server
            nixd
            pyright
            ruff
            yaml-language-server
            taplo
            python311Packages.debugpy
          ]);
          shellHook = ''
            ${self.checks.${system}.pre-commit-check.shellHook}
            exec nu
          '';
        };
      });
    };
}
