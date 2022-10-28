#!/bin/bash

# we want exit immediately if any command fails and we want error in piped commands to be preserved
set -eo pipefail

script_dir="$(dirname $0)/"

cd $script_dir

clang-tidy --quiet test.cpp --
