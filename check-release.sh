#!/bin/bash
# Decides whether CI has to build and release, and writes skip/changed/version
# to $GITHUB_OUTPUT. A build is needed when update-version.sh bumped PKGBUILD,
# and also when PKGBUILD was bumped by hand but that version has no release yet.
set -euo pipefail

./update-version.sh

pkgver=$(sed -n 's/^pkgver=//p' PKGBUILD)
pkgrel=$(sed -n 's/^pkgrel=//p' PKGBUILD)
version="${pkgver}-${pkgrel}"

if git diff --quiet HEAD -- PKGBUILD; then
  changed=no
else
  changed=yes
fi

# Only 404 means "not released". Any other failure stops the job, otherwise a
# network or auth error would be taken as a missing release and rebuild it.
auth=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
  auth=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi
status=$(curl -sS -o /dev/null -w '%{http_code}' "${auth[@]}" \
  -H "Accept: application/vnd.github+json" \
  "https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/tags/${version}")
case "$status" in
  200) released=yes ;;
  404) released=no ;;
  *)
    echo "Failed to look up release ${version}: HTTP ${status}" >&2
    exit 1
    ;;
esac

if [ "$changed" = yes ] || [ "$released" = no ]; then
  skip=no
else
  skip=yes
fi

echo "version=${version} changed=${changed} released=${released} skip=${skip}"
{
  echo "skip=${skip}"
  echo "changed=${changed}"
  echo "version=${version}"
} >> "$GITHUB_OUTPUT"
