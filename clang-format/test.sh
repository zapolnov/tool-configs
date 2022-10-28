#!/bin/bash

# we want exit immediately if any command fails and we want error in piped commands to be preserved
set -eo pipefail

script_dir="$(dirname $0)/"

cd $script_dir

clang-format sample.cpp > out.cpp

cmp out.cpp expect.cpp || (echo "error: clang-format test failed" && exit 1)

rm out.cpp
