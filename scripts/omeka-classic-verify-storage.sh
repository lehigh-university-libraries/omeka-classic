#!/usr/bin/env sh

set -eu

readonly storage_root=/var/www/omeka-classic/files

test -r "$storage_root"
test -w "$storage_root"

if test "${1:-}" != "--disposable"; then
  echo 'storage writable'
  exit 0
fi

probe="$storage_root/.omeka-verify-$$"
cleanup() {
  rm -f -- "$probe"
}
trap cleanup EXIT INT TERM

printf '%s' omeka-verify > "$probe"
test "$(cat "$probe")" = omeka-verify

cleanup
trap - EXIT INT TERM
echo 'storage round trip complete'
