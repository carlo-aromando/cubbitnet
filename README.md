# `cubbitnet`

`cubbitnet` is a Go library providing node-to-node communication primitives, allowing you to create nodes that send and receive messages.

## Project Structure

- `pkg/` - Exportable packages
- `internal/` - Internal packages
- `examples/` - Example programs demonstrating usage
- `tests/` - End-to-end tests
- `flake.nix` - Nix flake for development environment and CI

## Installation

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

---
