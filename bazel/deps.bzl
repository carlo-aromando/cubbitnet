load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_git_repository", "nixpkgs_package")
load("@bazel_gazelle//:deps.bzl", "go_repository")

def cubbitnet_dependencies(repo="@com_github_carlo_aromando_cubbitnet"):
    nixpkgs_git_repository(
        name = "nixpkgs",
        revision = "fc02ee70efb805d3b2865908a13ddd4474557ecf",
    )
    nixpkgs_package(
        name = "rocksdb.internal",
        attribute_path = "rocksdb",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "rocksdb.nix",
        attribute_path = "rocksdb",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "rocksdb",
    srcs = ["@rocksdb.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
        """,
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "snappy.internal",
        attribute_path = "snappy",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "snappy.nix",
        attribute_path = "snappy.dev",
        repository = "@nixpkgs",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "snappy",
    srcs = ["@snappy.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
    )
    nixpkgs_package(
        name = "zlib.internal",
        attribute_path = "zlib",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "zlib.nix",
        attribute_path = "zlib.dev",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "zlib",
    srcs = ["@zlib.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "bzip2.internal",
        attribute_path = "bzip2.out",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "bzip2.nix",
        attribute_path = "bzip2.dev",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "bzip2",
    srcs = ["@bzip2.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "lz4.internal",
        attribute_path = "lz4.lib",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "lz4.nix",
        attribute_path = "lz4.dev",
        repository = "@nixpkgs",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "lz4",
    srcs = ["@lz4.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
    )    
    nixpkgs_package(
        name = "zstd.internal",
        attribute_path = "zstd.out",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "zstd.nix",
        attribute_path = "zstd.dev",
        repository = "@nixpkgs",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "zstd",
    srcs = ["@zstd.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
        """
    )
    nixpkgs_package(
        name = "liburing.internal",
        attribute_path = "liburing.out",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "liburing.nix",
        attribute_path = "liburing.dev",
        repository = "@nixpkgs",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "liburing",
    srcs = ["@liburing.internal//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
        """
    )
    go_repository(
        name = "com_github_linxgnu_grocksdb",
        build_directives = ["\"gazelle:default_visibility //visibility:public\""],
        build_file_proto_mode = "disable",
        importpath = "github.com/linxGnu/grocksdb",
        sum = "h1:YX6gUcKvSC3d0s9DaqgbU+CRkZHzlELgHu1Z/kmtslg=",
        version = "v1.10.1",
        patch_args = ["-p0"],
        patches = [
            repo + "//patches:grocksdb_move_bindings.patch",
            repo + "//patches:grocksdb_buildfile.patch",
            repo + "//patches:grocksdb_remove_clinkopts.patch",
            repo + "//patches:grocksdb_add_liburing.patch",
        ],
    )

