load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def cubbitnet_prelude():
    # rules_nixpkgs
    http_archive(
        name = "io_tweag_rules_nixpkgs",
        strip_prefix = "rules_nixpkgs-cbaa7e62e9c4da23df247809a8f97db0e124ec8c",
        urls = ["https://github.com/tweag/rules_nixpkgs/archive/cbaa7e62e9c4da23df247809a8f97db0e124ec8c.tar.gz"],
    )
