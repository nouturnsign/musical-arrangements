#!/bin/sh
# helper script for installing projects by version
# usage:   ./helper.sh <identifier> <version>
# example: ./helper.sh first-rate-town v0.2.2

if [ $# -ne 2 ] ; then
    echo "Wrong number of arguments: expected 2, got $#"
    exit 1
fi

SOURCE_DIR="source/$1"
EXPORT_GENERAL_DIR="export/$1"
EXPORT_VERSION_DIR="export/$1/$2"

if [ ! -d "$SOURCE_DIR" ] ; then
    echo "Project $1 has not been added as git submodule yet."
    exit 2
fi

cd "$SOURCE_DIR"
git checkout main
git pull
make clean
git checkout "$2"
make -j 3
make install
cd ../..

mkdir -p "$EXPORT_GENERAL_DIR"
mkdir "$EXPORT_VERSION_DIR"
cp "$SOURCE_DIR"/install/* "$EXPORT_VERSION_DIR"

