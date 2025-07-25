{
  description = "Cubbit Network Go Library";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }: flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        buildInputs = [
          pkgs.go
          pkgs.gopls
          pkgs.golangci-lint
          pkgs.gotools
        ];
        shellHook = ''
          echo "Welcome to cubbitnet dev shell"
        '';
      };
    });
}
