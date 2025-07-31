load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_git_repository")
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_package")

def cubbitnet_dependencies():
    # register local nixpkgs repository
    rules_nixpkgs_dependencies()

    nixpkgs_git_repository(
        name = "nixpkgs",
        revision = "11707dc2f618dd54ca8739b309ec4fc024de578b",
    )

    # nixpkgs
    nixpkgs_package(
        name = "rocksdb.internal",
        attribute_path = "rocksdb",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "rocksdb",
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
        name = "snappy",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "snappy.dev",
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
    srcs = ["@snappy//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
    )
    nixpkgs_package(
        name = "zlib",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "zlib.dev",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "zlib",
    srcs = ["@zlib//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "bzip2.out",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "bzip2.dev",
        build_file_content = """\
load("@rules_cc//cc:defs.bzl", "cc_library")
filegroup(
    name = "include",
    srcs = glob(["include/**/*.h"]),
    visibility = ["//visibility:public"],
)
cc_library(
    name = "bzip2",
    srcs = ["@bzip2.out//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "lz4.lib",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "lz4.dev",
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
    srcs = ["@lz4.lib//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
    """,
    )    
    nixpkgs_package(
        name = "zstd.out",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "zstd.dev",
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
    srcs = ["@zstd.out//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
        """
    )
    nixpkgs_package(
        name = "liburing.out",
        repository = "@nixpkgs",
    )
    nixpkgs_package(
        name = "liburing.dev",
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
    srcs = ["@liburing.out//:lib"],
    hdrs = [":include"],
    strip_include_prefix = "include",
    visibility = ["//visibility:public"],
)
        """
    )

