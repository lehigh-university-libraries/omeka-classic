#!/usr/bin/env sh

set -eu

found=0
for root in "$@"; do
  if test ! -d "$root"; then
    continue
  fi
  if find "$root" -type f -name '*.php' | grep -q .; then
    find "$root" -type f -name '*.php' -exec php -l {} \;
    found=1
  fi
done

if test "$found" -eq 0; then
  echo 'No custom Omeka Classic PHP files found; skipping PHP lint.'
fi
