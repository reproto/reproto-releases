#!/bin/sh

set -e

version=$1

if [[ -z $version ]]; then
    echo "Usage: $0 <version>"
    exit 1
fi

echo $version > version
git add version
git commit -m "release $version"
git tag $version
git push origin HEAD --tags
