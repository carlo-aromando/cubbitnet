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
        LD_LIBRARY_PATH = with pkgs; lib.makeLibraryPath [
          stdenv.cc.cc
          rocksdb
          snappy
          zlib
          bzip2
          lz4
          zstd
          liburing
        ];
        CGO_ENABLED = "1";
        CGO_CFLAGS = "-I${pkgs.rocksdb}/include";
        CGO_LDFLAGS = "-L${pkgs.rocksdb}/lib -lrocksdb -lsnappy -lz -lbz2 -llz4 -lzstd -lstdc++ -luring";
        packages = with pkgs; [
          # local development tools
          go
          gopls
          golangci-lint
          gotools
          goreleaser

          # local development deps
          rocksdb
          snappy
          zlib
          bzip2
          lz4
          zstd
          liburing

          # bazel development
          bazel_7
        ];
        shellHook = ''
          echo "Welcome to cubbitnet dev shell"
        '';
      };
    });
}
