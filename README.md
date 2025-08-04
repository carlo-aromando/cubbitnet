# `cubbitnet`

`cubbitnet` is a Go library providing node-to-node communication primitives, allowing you to create nodes that send and receive messages.

## Project Structure

- `pkg/` - Exportable packages
- `internal/` - Internal packages
- `examples/` - Example programs demonstrating usage
- `test/` - End-to-end tests
- `flake.nix` - Nix flake for development environment and CI

## Build

Make sure you have Go 1.24 installed, or use the provided Nix environment:

```bash
nix develop
go mod tidy
```

## Usage

### Running the example

You can run the example without changing directory into the example folder.
From the root of the project, simply execute:

```bash
go run ./examples/simple
go run ./examples/db
```

Make sure you run the command from the project root (where `go.mod` is located) to preserve the module context.

## Testing

Run all tests with:

```bash
go test ./...
```

## Linting

Use the provided Nix flake environment and run:

```bash
golangci-lint run
```

## Generating Documentation

You can generate or view documentation locally using the built-in `go doc` tool.

To display documentation for a package, run:

```bash
go doc ./pkg/node
```

Alternatively, you can install (it is already provided by the Nix shell) and run `godoc` to start a local web server with browsable docs:

```bash
godoc -http=:6060
```

Then open your browser at [http://localhost:6060/pkg/](http://localhost:6060/pkg/) to explore the documentation.

## Continuous Integration

The project uses GitHub Actions with Nix to run build, test, and lint steps separately. See `.github/workflows/ci.yml` for details.

## Bazel integration

This library requires [Nix](https://nixos.org) to be installed.

To add it to your Bazel project, include the following in your WORKSPACE file:

```python
# rules_nixpkgs
http_archive(
    name = "io_tweag_rules_nixpkgs",
    strip_prefix = "rules_nixpkgs-a0548813a1d3d3d08e2f1952ea0a9b1777ed160b",
    urls = ["https://github.com/carlo-aromando/rules_nixpkgs/archive/a0548813a1d3d3d08e2f1952ea0a9b1777ed160b.tar.gz"],
)

load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")
rules_nixpkgs_dependencies()

# cubbitnet dependencies
http_archive(
    name = "com_github_carlo_aromando_cubbitnet",
    strip_prefix = "cubbitnet-0.1.8",
    url = "https://github.com/carlo-aromando/cubbitnet/archive/refs/tags/v0.1.8.tar.gz",
)

load("@com_github_carlo_aromando_cubbitnet//bazel:deps.bzl", "cubbitnet_dependencies")
cubbitnet_dependencies()
```

### Example Usage with go_binary
After adding the required dependencies to your WORKSPACE file (as shown above), you can use the library in your Bazel Go targets.

Here's a minimal example using go_binary:

`BUILD.bazel`

```python
load("@io_bazel_rules_go//go:def.bzl", "go_binary", "go_library")

go_binary(
    name = "app",
    embed = [":lib"],
)

go_library(
    name = "lib",
    srcs = ["main.go"],
    importpath = "example.com/app",
    deps = [
        "@com_github_carlo_aromando_cubbitnet//pkg/db",
    ],
)
```

`main.go`

```go
package main

import (
    "github.com/carlo-aromando/cubbitnet/pkg/db"
)

func main() {
    db.Test()
}
```

Build the binary with:

```
bazel build //:app
```


---



