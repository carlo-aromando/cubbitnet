load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

# rules_go
http_archive(
    name = "io_bazel_rules_go",
    sha256 = "b78f77458e77162f45b4564d6b20b6f92f56431ed59eaaab09e7819d1d850313",
    urls = [
        "https://mirror.bazel.build/github.com/bazel-contrib/rules_go/releases/download/v0.53.0/rules_go-v0.53.0.zip",
        "https://github.com/bazel-contrib/rules_go/releases/download/v0.53.0/rules_go-v0.53.0.zip",
    ],
)

# deps
load("//bazel:prelude.bzl", "cubbitnet_prelude")
cubbitnet_prelude()
load("//bazel:deps.bzl", "cubbitnet_dependencies")
cubbitnet_dependencies()

# go dependencies
load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
go_rules_dependencies()
go_register_toolchains(version = "1.24.4")

# gazelle
http_archive(
    name = "bazel_gazelle",
    integrity = "sha256-XYDmKnAxTznMdkwcPqqADFk2yfHqkWJQBiJ85NIM0IY=",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.42.0/bazel-gazelle-v0.42.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.42.0/bazel-gazelle-v0.42.0.tar.gz",
    ],
)

load("//third_party:repositories.bzl", "go_repositories")
# gazelle:repository_macro third_party/repositories.bzl%go_repositories
go_repositories()

load("@bazel_gazelle//:deps.bzl", "go_repository")
go_repository(
    name = "com_github_linxgnu_grocksdb",
    build_directives = ["\"gazelle:default_visibility //visibility:public\""],
    build_file_proto_mode = "disable",
    importpath = "github.com/linxGnu/grocksdb",
    sum = "h1:YX6gUcKvSC3d0s9DaqgbU+CRkZHzlELgHu1Z/kmtslg=",
    version = "v1.10.1",
    patch_args = ["-p0"],
    patches = [
        "//patches:grocksdb_move_bindings.patch",
        "//patches:grocksdb_buildfile.patch",
        "//patches:grocksdb_remove_clinkopts.patch",
        "//patches:grocksdb_add_liburing.patch",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
gazelle_dependencies(go_sdk = "go_sdk")
