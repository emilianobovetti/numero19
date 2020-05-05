#!/bin/bash -eu

github_latest_url="https://api.github.com/repos/gohugoio/hugo/releases/latest"
github_latest_releases="$(curl "$github_latest_url")"
jq_filter='.assets[] | select(.name | endswith("Linux-64bit.tar.gz")) | .browser_download_url'
download_url="$(echo "$github_latest_releases" | jq --raw-output "$jq_filter" | head -n 1)"

if [ -z "$download_url" ]; then
  echo "Cannot find Hugo download url"
  exit 1
fi

hugo_tgz_name="hugo.tar.gz"

trap "rm -f \"$hugo_tgz_name\"" EXIT

curl -L "$download_url" --output "$hugo_tgz_name"
mkdir -p bin
tar zxf "$hugo_tgz_name" -C bin hugo
