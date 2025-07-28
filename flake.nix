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
          pkgs.rocksdb
          pkgs.snappy
          pkgs.zlib
          pkgs.bzip2
          pkgs.lz4
          pkgs.zstd
          pkgs.goreleaser
        ];
        shellHook = ''
          export CGO_ENABLED=1
          export CGO_CFLAGS="-I${pkgs.rocksdb}/include"
          export CGO_LDFLAGS="-L${pkgs.rocksdb}/lib -lrocksdb -lsnappy -lz -lbz2 -llz4 -lzstd -lstdc++"
          echo "Welcome to cubbitnet dev shell"
        '';
      };
    });
}
